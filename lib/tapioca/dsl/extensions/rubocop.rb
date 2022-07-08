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
      module Extensions
        module Rubocop
          extend T::Sig

          MethodName = T.type_alias { T.any(String, Symbol) }

          sig { params(name: MethodName, _args: T.untyped, defaults: T.untyped).returns(MethodName) }
          def def_node_matcher(name, *_args, **defaults)
            __tapioca_node_matchers << name
            __tapioca_node_matchers << :"without_defaults_#{name}" unless defaults.empty?

            super
          end

          sig { params(name: MethodName, _args: T.untyped, defaults: T.untyped).returns(MethodName) }
          def def_node_search(name, *_args, **defaults)
            __tapioca_node_searches << name
            __tapioca_node_searches << :"without_defaults_#{name}" unless defaults.empty?

            super
          end

          sig { returns(T::Array[MethodName]) }
          def __tapioca_node_matchers
            @__tapioca_node_matchers = T.let(@__tapioca_node_matchers, T.nilable(T::Array[MethodName]))
            @__tapioca_node_matchers ||= []
          end

          sig { returns(T::Array[MethodName]) }
          def __tapioca_node_searches
            @__tapioca_node_searches = T.let(@__tapioca_node_searches, T.nilable(T::Array[MethodName]))
            @__tapioca_node_searches ||= []
          end

          ::RuboCop::Cop::Base.singleton_class.prepend(self)
        end
      end
    end
  end
end
