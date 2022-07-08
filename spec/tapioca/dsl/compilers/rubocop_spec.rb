# typed: strict
# frozen_string_literal: true

require "spec_helper"
require "rubocop"
require "rubocop-sorbet"

module Tapioca
  module Dsl
    module Compilers
      class RubocopSpec < ::DslSpec
        describe "Tapioca::Dsl::Compilers::Rubocop" do
          sig { void }
          def before_setup
            require "tapioca/dsl/extensions/rubocop"
            super
          end

          describe "initialize" do
            it "gathers no constants if there are no classes that inherit from Rubocop::Cop::Base" do
              assert_empty(gathered_constants)
            end

            it "gathers only cops defined in the app" do
              add_ruby_file("content.rb", <<~RUBY)
                class MyCop < ::RuboCop::Cop::Base
                end

                class MyLegacyCop < ::RuboCop::Cop::Cop
                end

                module ::RuboCop
                  module Cop
                    module MyApp
                      class MyNamespacedCop < Base
                      end
                    end
                  end
                end
              RUBY

              assert_equal(["MyCop", "MyLegacyCop", "RuboCop::Cop::MyApp::MyNamespacedCop"], gathered_constants)
            end
          end

          describe "decorate" do
            it "generates empty RBI when no DSL used" do
              add_ruby_file("content.rb", <<~RUBY)
                class MyCop < ::RuboCop::Cop::Base
                end
              RUBY

              expected = <<~RBI
                # typed: strong
              RBI

              assert_equal(expected, rbi_for(:MyCop))
            end

            it "generates correct RBI file" do
              add_ruby_file("content.rb", <<~RUBY)
                class MyCop < ::RuboCop::Cop::Base
                  def_node_matcher :some_matcher, "(...)"
                  def_node_matcher :some_matcher_with_params, "(%1 %two ...)"
                  def_node_matcher :some_matcher_with_params_and_defaults, "(%1 %two ...)", two: :default
                  def_node_search :some_search, "(...)"
                  def_node_search :some_search_with_params, "(%1 %two ...)"
                  def_node_search :some_search_with_params_and_defaults, "(%1 %two ...)", two: :default

                  def on_send(node);end
                end
              RUBY

              expected = <<~RBI
                # typed: strong

                class MyCop
                  sig { params(param0: T.untyped).returns(T.untyped) }
                  def some_matcher(param0 = T.unsafe(nil)); end

                  sig { params(param0: T.untyped, param1: T.untyped, two: T.untyped).returns(T.untyped) }
                  def some_matcher_with_params(param0 = T.unsafe(nil), param1, two:); end

                  sig { params(args: T.untyped, values: T.untyped).returns(T.untyped) }
                  def some_matcher_with_params_and_defaults(*args, **values); end

                  sig { params(param0: T.untyped).returns(T.untyped) }
                  def some_search(param0); end

                  sig { params(param0: T.untyped, param1: T.untyped, two: T.untyped).returns(T.untyped) }
                  def some_search_with_params(param0, param1, two:); end

                  sig { params(args: T.untyped, values: T.untyped).returns(T.untyped) }
                  def some_search_with_params_and_defaults(*args, **values); end

                  sig { params(param0: T.untyped, param1: T.untyped, two: T.untyped).returns(T.untyped) }
                  def without_defaults_some_matcher_with_params_and_defaults(param0 = T.unsafe(nil), param1, two:); end

                  sig { params(param0: T.untyped, param1: T.untyped, two: T.untyped).returns(T.untyped) }
                  def without_defaults_some_search_with_params_and_defaults(param0, param1, two:); end
                end
              RBI

              assert_equal(expected, rbi_for(:MyCop))
            end
          end
        end
      end
    end
  end
end
