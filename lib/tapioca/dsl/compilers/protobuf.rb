# typed: strict
# frozen_string_literal: true

begin
  require "google/protobuf"
rescue LoadError
  return
end

module Tapioca
  module Dsl
    module Compilers
      # `Tapioca::Dsl::Compilers::Protobuf` decorates RBI files for subclasses of
      # [`Google::Protobuf::MessageExts`](https://github.com/protocolbuffers/protobuf/tree/master/ruby).
      #
      # For example, with the following "cart.rb" file:
      #
      # ~~~rb
      # Google::Protobuf::DescriptorPool.generated_pool.build do
      #   add_file("cart.proto", :syntax => :proto3) do
      #     add_message "MyCart" do
      #       optional :shop_id, :int32, 1
      #       optional :customer_id, :int64, 2
      #       optional :number_value, :double, 3
      #       optional :string_value, :string, 4
      #     end
      #   end
      # end
      # ~~~
      #
      # this compiler will produce the RBI file `cart.rbi` with the following content:
      #
      # ~~~rbi
      # # cart.rbi
      # # typed: strong
      # class Cart
      #   sig { returns(Integer) }
      #   def customer_id; end
      #
      #   sig { params(month: Integer).returns(Integer) }
      #   def customer_id=(value); end
      #
      #   sig { returns(Integer) }
      #   def shop_id; end
      #
      #   sig { params(value: Integer).returns(Integer) }
      #   def shop_id=(value); end
      #
      #   sig { returns(String) }
      #   def string_value; end
      #
      #   sig { params(value: String).returns(String) }
      #   def string_value=(value); end
      #
      #
      #   sig { returns(Float) }
      #   def number_value; end
      #
      #   sig { params(value: Float).returns(Float) }
      #   def number_value=(value); end
      # end
      # ~~~
      #
      # Please note that you might have to ignore the originally generated Protobuf Ruby files
      # to avoid _Redefining constant_ issues when doing type checking.
      # Do this by extending your Sorbet config file:
      #
      # ~~~
      # --ignore=/path/to/proto/cart_pb.rb
      # ~~~
      class Protobuf < Compiler
        class Field < T::Struct
          prop :name, String
          prop :type, String
          prop :init_type, String
          prop :default, String
        end

        extend T::Sig

        ConstantType = type_member { { fixed: Module } }

        FIELD_RE = /^[a-z_][a-zA-Z0-9_]*$/

        sig { override.void }
        def decorate
          root.create_path(constant) do |klass|
            if constant == Google::Protobuf::RepeatedField
              create_type_members(klass, "Elem")
            elsif constant == Google::Protobuf::Map
              create_type_members(klass, "Key", "Value")
            else
              descriptor = T.let(T.unsafe(constant).descriptor, Google::Protobuf::Descriptor)
              descriptor.each_oneof { |oneof| create_oneof_method(klass, oneof) }
              fields = descriptor.map { |desc| create_descriptor_method(klass, desc) }
              fields.sort_by!(&:name)

              parameters = fields.map do |field|
                create_kw_opt_param(field.name, type: field.init_type, default: field.default)
              end

              if fields.all? { |field| FIELD_RE.match?(field.name) }
                klass.create_method("initialize", parameters: parameters, return_type: "void")
              else
                # One of the fields has an incorrect name for a named parameter so creating the default initialize for
                # it would create a RBI with a syntax error.
                # The workaround is to create an initialize that takes a **kwargs instead.
                kwargs_parameter = create_kw_rest_param("fields", type: "T.untyped")
                klass.create_method("initialize", parameters: [kwargs_parameter], return_type: "void")
              end
            end
          end
        end

        sig { override.returns(T::Enumerable[Module]) }
        def self.gather_constants
          marker = Google::Protobuf::MessageExts::ClassMethods
          results = T.cast(ObjectSpace.each_object(marker).to_a, T::Array[Module])
          results.any? ? results + [Google::Protobuf::RepeatedField, Google::Protobuf::Map] : []
        end

        private

        sig { params(klass: RBI::Scope, names: String).void }
        def create_type_members(klass, *names)
          klass.create_extend("T::Generic")

          names.each do |name|
            klass.create_type_variable(name, type: "type_member")
          end
        end

        sig do
          params(
            descriptor: Google::Protobuf::FieldDescriptor
          ).returns(String)
        end
        def type_of(descriptor)
          case descriptor.type
          when :enum
            descriptor.subtype.enummodule.name
          when :message
            descriptor.subtype.msgclass.name
          when :int32, :int64, :uint32, :uint64
            "Integer"
          when :double, :float
            "Float"
          when :bool
            "T::Boolean"
          when :string, :bytes
            "String"
          else
            "T.untyped"
          end
        end

        sig { params(descriptor: Google::Protobuf::FieldDescriptor).returns(T::Boolean) }
        def nilable_descriptor?(descriptor)
          descriptor.label == :optional && descriptor.type == :message
        end

        sig { params(descriptor: Google::Protobuf::FieldDescriptor).returns(Field) }
        def field_of(descriptor)
          if descriptor.label == :repeated
            # Here we're going to check if the submsg_name is named according to
            # how Google names map entries.
            # https://github.com/protocolbuffers/protobuf/blob/f82e26/ruby/ext/google/protobuf_c/defs.c#L1963-L1966
            if descriptor.submsg_name.to_s.end_with?("_MapEntry_#{descriptor.name}")
              key = descriptor.subtype.lookup("key")
              value = descriptor.subtype.lookup("value")

              key_type = type_of(key)
              value_type = type_of(value)
              type = "Google::Protobuf::Map[#{key_type}, #{value_type}]"

              default_args = [key.type.inspect, value.type.inspect]
              default_args << value_type if [:enum, :message].include?(value.type)

              Field.new(
                name: descriptor.name,
                type: type,
                init_type: "T.any(#{type}, T::Hash[#{key_type}, #{value_type}])",
                default: "Google::Protobuf::Map.new(#{default_args.join(", ")})"
              )
            else
              elem_type = type_of(descriptor)
              type = "Google::Protobuf::RepeatedField[#{elem_type}]"

              default_args = [descriptor.type.inspect]
              default_args << elem_type if [:enum, :message].include?(descriptor.type)

              Field.new(
                name: descriptor.name,
                type: type,
                init_type: "T.any(#{type}, T::Array[#{elem_type}])",
                default: "Google::Protobuf::RepeatedField.new(#{default_args.join(", ")})"
              )
            end
          else
            type = type_of(descriptor)
            type = as_nilable_type(type) if nilable_descriptor?(descriptor)

            Field.new(
              name: descriptor.name,
              type: type,
              init_type: type,
              default: "nil"
            )
          end
        end

        sig do
          params(
            klass: RBI::Scope,
            desc: Google::Protobuf::FieldDescriptor,
          ).returns(Field)
        end
        def create_descriptor_method(klass, desc)
          field = field_of(desc)

          klass.create_method(
            field.name,
            return_type: field.type
          )

          klass.create_method(
            "#{field.name}=",
            parameters: [create_param("value", type: field.type)],
            return_type: field.type
          )

          field
        end

        sig do
          params(
            klass: RBI::Scope,
            desc: Google::Protobuf::OneofDescriptor
          ).void
        end
        def create_oneof_method(klass, desc)
          klass.create_method(
            desc.name,
            return_type: "T.nilable(Symbol)"
          )
        end
      end
    end
  end
end
