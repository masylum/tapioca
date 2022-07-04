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
          def def_node_matcher(name, *, **defaults)
            __tapioca_node_matchers << name
            __tapioca_node_matchers << :"without_defaults_#{name}" unless defaults.empty?

            super
          end

          def def_node_search(name, *, **defaults)
            __tapioca_node_searches << name
            __tapioca_node_searches << :"without_defaults_#{name}" unless defaults.empty?

            super
          end

          def __tapioca_node_matchers
            @__tapioca_node_matchers = T.let(@__tapioca_node_matchers, T.nilable(T::Array[Symbol]))
            @__tapioca_node_matchers ||= []
          end

          def __tapioca_node_searches
            @__tapioca_node_searches = T.let(@__tapioca_node_searches, T.nilable(T::Array[Symbol]))
            @__tapioca_node_searches ||= []
          end

          ::RuboCop::Cop::Base.singleton_class.prepend(self)
        end
      end
    end
  end
end
