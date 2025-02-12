# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `minitest-hooks` gem.
# Please instead update this file by running `bin/tapioca gem minitest-hooks`.

# Add support for around and before_all/after_all/around_all hooks to
# minitest spec classes.
#
# source://minitest-hooks-1.5.0/lib/minitest/hooks/test.rb:5
module Minitest::Hooks
  mixes_in_class_methods ::Minitest::Hooks::ClassMethods

  # Empty method, necessary so that super calls in spec subclasses work.
  #
  # source://minitest-hooks-1.5.0/lib/minitest/hooks/test.rb:21
  def after_all; end

  # Method that just yields, so that super calls in spec subclasses work.
  #
  # source://minitest-hooks-1.5.0/lib/minitest/hooks/test.rb:30
  def around; end

  # Method that just yields, so that super calls in spec subclasses work.
  #
  # source://minitest-hooks-1.5.0/lib/minitest/hooks/test.rb:25
  def around_all; end

  # Empty method, necessary so that super calls in spec subclasses work.
  #
  # source://minitest-hooks-1.5.0/lib/minitest/hooks/test.rb:17
  def before_all; end

  # Run around hook inside, since time_it is run around every spec.
  #
  # source://minitest-hooks-1.5.0/lib/minitest/hooks/test.rb:35
  def time_it; end

  class << self
    # Add the class methods to the class. Also, include an additional
    # module in the class that before(:all) and after(:all) methods
    # work on a class that directly includes this module.
    #
    # source://minitest-hooks-1.5.0/lib/minitest/hooks/test.rb:9
    def included(mod); end
  end
end

# source://minitest-hooks-1.5.0/lib/minitest/hooks/test.rb:44
module Minitest::Hooks::ClassMethods
  # If type is :all, set the after_all hook instead of the after hook.
  #
  # source://minitest-hooks-1.5.0/lib/minitest/hooks/test.rb:123
  def after(type = T.unsafe(nil), &block); end

  # If type is :all, set the around_all hook, otherwise set the around hook.
  #
  # source://minitest-hooks-1.5.0/lib/minitest/hooks/test.rb:104
  def around(type = T.unsafe(nil), &block); end

  # If type is :all, set the before_all hook instead of the before hook.
  #
  # source://minitest-hooks-1.5.0/lib/minitest/hooks/test.rb:110
  def before(type = T.unsafe(nil), &block); end

  # Unless name is NEW, return a dup singleton instance.
  #
  # source://minitest-hooks-1.5.0/lib/minitest/hooks/test.rb:50
  def new(name); end

  # When running the specs in the class, first create a singleton instance, the singleton is
  # used to implement around_all/before_all/after_all hooks, and each spec will run as a
  # dup of the singleton instance.
  #
  # source://minitest-hooks-1.5.0/lib/minitest/hooks/test.rb:64
  def with_info_handler(reporter, &block); end

  private

  # source://minitest-hooks-1.5.0/lib/minitest/hooks/test.rb:137
  def _record_minitest_hooks_error(reporter, instance); end
end

# Object used to get an empty new instance, as new by default will return
# a dup of the singleton instance.
#
# source://minitest-hooks-1.5.0/lib/minitest/hooks/test.rb:47
Minitest::Hooks::ClassMethods::NEW = T.let(T.unsafe(nil), Object)

# Spec subclass that includes the hook methods.
#
# source://minitest-hooks-1.5.0/lib/minitest/hooks.rb:5
class Minitest::HooksSpec < ::Minitest::Spec
  include ::Minitest::Hooks
  extend ::Minitest::Hooks::ClassMethods
end
