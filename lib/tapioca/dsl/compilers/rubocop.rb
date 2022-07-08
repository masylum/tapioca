# typed: strict
# frozen_string_literal: true

begin
  require "rubocop"
rescue LoadError
  return
end

module Tapioca
  module Dsl
    module Compilers
      # TODO: documentation
      # TODO: Should we call this Rubocop or RuboCop?
      class Rubocop < Compiler
        GEM_LOAD_PATH_PREFIX_PATTERN = %r{\A#{Regexp.union(
          ::Gem.loaded_specs.each_value.flat_map(&:load_paths),
        )}}

        ConstantType = type_member { { fixed: T.all(T.class_of(::RuboCop::Cop::Base), Extensions::Rubocop) } }

        sig { override.returns(T::Enumerable[Class]) }
        def self.gather_constants
          descendants_of(::RuboCop::Cop::Base).reject do |constant|
            constant_name = name_of(constant)
            next true if constant_name.nil?

            # All cops (built-in, extensions, custom) are supposed to be of the
            # form ::Rubocop::Cop::<department>::<name>, so we can't just look at
            # the name prefix. Best we can do is look at if the constant
            # definition path is in a gem or not.

            path = const_source_location(constant_name)&.first
            next true if path.nil?

            GEM_LOAD_PATH_PREFIX_PATTERN.match?(path)
          end
        end

        sig { override.void }
        def decorate
          return unless used_macros?

          root.create_path(constant) do |cop_klass|
            node_matchers.each do |name|
              create_method_from_def(cop_klass, constant.instance_method(name))
            end

            node_searches.each do |name|
              create_method_from_def(cop_klass, constant.instance_method(name))
            end
          end
        end

        private

        sig { returns(T::Boolean) }
        def used_macros?
          return true unless node_matchers.empty?
          return true unless node_searches.empty?

          false
        end

        sig { returns(T::Array[Extensions::Rubocop::MethodName]) }
        def node_matchers
          constant.__tapioca_node_matchers
        end

        sig { returns(T::Array[Extensions::Rubocop::MethodName]) }
        def node_searches
          constant.__tapioca_node_searches
        end
      end
    end
  end
end
