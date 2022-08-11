# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `pry-byebug` gem.
# Please instead update this file by running `bin/tapioca gem pry-byebug`.

# source://pry-byebug//lib/byebug/processors/pry_processor.rb#5
module Byebug
  extend ::Byebug::Helpers::ReflectionHelper

  def displays; end
  def displays=(_arg0); end
  def init_file; end
  def init_file=(_arg0); end
  def mode; end
  def mode=(_arg0); end
  def run_init_script; end

  private

  def add_catchpoint(_arg0); end
  def breakpoints; end
  def catchpoints; end
  def contexts; end
  def current_context; end
  def debug_load(*_arg0); end
  def lock; end
  def post_mortem=(_arg0); end
  def post_mortem?; end
  def raised_exception; end
  def rc_dirs; end
  def run_rc_file(rc_file); end
  def start; end
  def started?; end
  def stop; end
  def stoppable?; end
  def thread_context(_arg0); end
  def tracing=(_arg0); end
  def tracing?; end
  def unlock; end
  def verbose=(_arg0); end
  def verbose?; end

  class << self
    def actual_control_port; end
    def actual_port; end
    def add_catchpoint(_arg0); end
    def attach; end
    def breakpoints; end
    def catchpoints; end
    def contexts; end
    def current_context; end
    def debug_load(*_arg0); end
    def handle_post_mortem; end
    def interrupt; end
    def load_settings; end
    def lock; end
    def parse_host_and_port(host_port_spec); end
    def post_mortem=(_arg0); end
    def post_mortem?; end
    def raised_exception; end
    def spawn(host = T.unsafe(nil), port = T.unsafe(nil)); end
    def start; end
    def start_client(host = T.unsafe(nil), port = T.unsafe(nil)); end
    def start_control(host = T.unsafe(nil), port = T.unsafe(nil)); end
    def start_server(host = T.unsafe(nil), port = T.unsafe(nil)); end
    def started?; end
    def stop; end
    def stoppable?; end
    def thread_context(_arg0); end
    def tracing=(_arg0); end
    def tracing?; end
    def unlock; end
    def verbose=(_arg0); end
    def verbose?; end
    def wait_connection; end
    def wait_connection=(_arg0); end

    private

    def client; end
    def control; end
    def server; end
  end
end

class Byebug::DebugThread < ::Thread
  class << self
    def inherited; end
  end
end

Byebug::PORT = T.let(T.unsafe(nil), Integer)

# Extends raw byebug's processor.
#
# source://pry-byebug//lib/byebug/processors/pry_processor.rb#9
class Byebug::PryProcessor < ::Byebug::CommandProcessor
  # Called when a breakpoint is hit. Note that `at_line`` is called
  # inmediately after with the context's `stop_reason == :breakpoint`, so we
  # must not resume the pry instance here
  #
  # source://pry-byebug//lib/byebug/processors/pry_processor.rb#88
  def at_breakpoint(breakpoint); end

  # Called when the debugger wants to stop right before the end of a class
  # definition
  #
  # source://pry-byebug//lib/byebug/processors/pry_processor.rb#79
  def at_end; end

  # Called when the debugger wants to stop at a regular line
  #
  # source://pry-byebug//lib/byebug/processors/pry_processor.rb#64
  def at_line; end

  # Called when the debugger wants to stop right before a method return
  #
  # source://pry-byebug//lib/byebug/processors/pry_processor.rb#71
  def at_return(_return_value); end

  def bold(*args, &block); end
  def output(*args, &block); end

  # Set up a number of navigational commands to be performed by Byebug.
  #
  # source://pry-byebug//lib/byebug/processors/pry_processor.rb#45
  def perform(action, options = T.unsafe(nil)); end

  # Returns the value of attribute pry.
  #
  # source://pry-byebug//lib/byebug/processors/pry_processor.rb#10
  def pry; end

  # Sets the attribute pry
  #
  # @param value the value to set the attribute pry to.
  #
  # source://pry-byebug//lib/byebug/processors/pry_processor.rb#10
  def pry=(_arg0); end

  # Wrap a Pry REPL to catch navigational commands and act on them.
  #
  # source://pry-byebug//lib/byebug/processors/pry_processor.rb#26
  def run(&_block); end

  private

  # source://pry-byebug//lib/byebug/processors/pry_processor.rb#101
  def n_hits(breakpoint); end

  # source://pry-byebug//lib/byebug/processors/pry_processor.rb#122
  def perform_backtrace(_options); end

  # source://pry-byebug//lib/byebug/processors/pry_processor.rb#150
  def perform_down(options); end

  # source://pry-byebug//lib/byebug/processors/pry_processor.rb#138
  def perform_finish(*_arg0); end

  # source://pry-byebug//lib/byebug/processors/pry_processor.rb#158
  def perform_frame(options); end

  # source://pry-byebug//lib/byebug/processors/pry_processor.rb#128
  def perform_next(options); end

  # source://pry-byebug//lib/byebug/processors/pry_processor.rb#133
  def perform_step(options); end

  # source://pry-byebug//lib/byebug/processors/pry_processor.rb#142
  def perform_up(options); end

  # Resume an existing Pry REPL at the paused point.
  #
  # source://pry-byebug//lib/byebug/processors/pry_processor.rb#110
  def resume_pry; end

  class << self
    # source://pry-byebug//lib/byebug/processors/pry_processor.rb#16
    def start; end
  end
end

class Byebug::ThreadsTable; end

# source://pry-byebug//lib/pry/byebug/breakpoints.rb#3
class Pry
  extend ::Forwardable

  def initialize(options = T.unsafe(nil)); end

  def add_sticky_local(name, &block); end
  def backtrace; end
  def backtrace=(_arg0); end
  def binding_stack; end
  def binding_stack=(_arg0); end
  def color(*args, &block); end
  def color=(*args, &block); end
  def commands(*args, &block); end
  def commands=(*args, &block); end
  def complete(str); end
  def config; end
  def current_binding; end
  def current_context; end
  def custom_completions; end
  def custom_completions=(_arg0); end
  def editor(*args, &block); end
  def editor=(*args, &block); end
  def eval(line, options = T.unsafe(nil)); end
  def eval_string; end
  def eval_string=(_arg0); end
  def evaluate_ruby(code); end
  def exception_handler(*args, &block); end
  def exception_handler=(*args, &block); end
  def exec_hook(name, *args, &block); end
  def exit_value; end
  def extra_sticky_locals(*args, &block); end
  def extra_sticky_locals=(*args, &block); end
  def hooks(*args, &block); end
  def hooks=(*args, &block); end
  def inject_local(name, value, binding); end
  def inject_sticky_locals!; end
  def input(*args, &block); end
  def input=(*args, &block); end
  def input_ring; end
  def last_dir; end
  def last_dir=(_arg0); end
  def last_exception; end
  def last_exception=(exception); end
  def last_file; end
  def last_file=(_arg0); end
  def last_result; end
  def last_result=(_arg0); end
  def last_result_is_exception?; end
  def memory_size; end
  def memory_size=(size); end
  def output; end
  def output=(*args, &block); end
  def output_ring; end
  def pager; end
  def pager=(*args, &block); end
  def pop_prompt; end
  def print(*args, &block); end
  def print=(*args, &block); end
  def process_command(val); end
  def process_command_safely(val); end
  def prompt; end
  def prompt=(new_prompt); end
  def push_binding(object); end
  def push_initial_binding(target = T.unsafe(nil)); end
  def push_prompt(new_prompt); end
  def quiet?; end
  def raise_up(*args); end
  def raise_up!(*args); end
  def raise_up_common(force, *args); end
  def repl(target = T.unsafe(nil)); end
  def reset_eval_string; end
  def run_command(val); end
  def select_prompt; end
  def set_last_result(result, code = T.unsafe(nil)); end
  def should_print?; end
  def show_result(result); end
  def sticky_locals; end
  def suppress_output; end
  def suppress_output=(_arg0); end
  def update_input_history(code); end

  private

  def ensure_correct_encoding!(val); end
  def generate_prompt(prompt_proc, conf); end
  def handle_line(line, options); end
  def prompt_stack; end

  class << self
    def Code(obj); end
    def Method(obj); end
    def WrappedModule(obj); end
    def auto_resize!; end
    def binding_for(target); end
    def cli; end
    def cli=(_arg0); end
    def color(*args, &block); end
    def color=(*args, &block); end
    def commands(*args, &block); end
    def commands=(*args, &block); end
    def config; end
    def config=(_arg0); end
    def configure; end
    def critical_section; end
    def current; end
    def current_line; end
    def current_line=(_arg0); end
    def custom_completions; end
    def custom_completions=(_arg0); end
    def editor(*args, &block); end
    def editor=(*args, &block); end
    def eval_path; end
    def eval_path=(_arg0); end
    def exception_handler(*args, &block); end
    def exception_handler=(*args, &block); end
    def extra_sticky_locals(*args, &block); end
    def extra_sticky_locals=(*args, &block); end
    def final_session_setup; end
    def history(*args, &block); end
    def history=(*args, &block); end
    def hooks(*args, &block); end
    def hooks=(*args, &block); end
    def in_critical_section?; end
    def init; end
    def initial_session?; end
    def initial_session_setup; end
    def input(*args, &block); end
    def input=(*args, &block); end
    def last_internal_error; end
    def last_internal_error=(_arg0); end
    def line_buffer; end
    def line_buffer=(_arg0); end
    def load_file_at_toplevel(file); end
    def load_file_through_repl(file_name); end
    def load_history; end
    def load_plugins(*args, &block); end
    def load_rc_files; end
    def load_requires; end
    def load_traps; end
    def load_win32console; end
    def locate_plugins(*args, &block); end
    def main; end
    def memory_size(*args, &block); end
    def memory_size=(*args, &block); end
    def output(*args, &block); end
    def output=(*args, &block); end
    def pager(*args, &block); end
    def pager=(*args, &block); end
    def plugins(*args, &block); end
    def print(*args, &block); end
    def print=(*args, &block); end
    def prompt(*args, &block); end
    def prompt=(*args, &block); end
    def quiet; end
    def quiet=(_arg0); end
    def rc_files_to_load; end
    def real_path_to(file); end
    def reset_defaults; end
    def run_command(command_string, options = T.unsafe(nil)); end

    # source://pry-byebug//lib/pry-byebug/pry_ext.rb#8
    def start(target = T.unsafe(nil), options = T.unsafe(nil)); end

    # source://pry-byebug//lib/pry-byebug/pry_ext.rb#8
    def start_with_pry_byebug(target = T.unsafe(nil), options = T.unsafe(nil)); end

    def start_without_pry_byebug(target = T.unsafe(nil), options = T.unsafe(nil)); end
    def toplevel_binding; end
    def toplevel_binding=(_arg0); end
    def view_clip(obj, options = T.unsafe(nil)); end
  end
end

Pry::BINDING_METHOD_IMPL = T.let(T.unsafe(nil), Array)

# source://pry-byebug//lib/pry/byebug/breakpoints.rb#4
module Pry::Byebug; end

# Wrapper for Byebug.breakpoints that respects our Processor and has better
# failure behavior. Acts as an Enumerable.
#
# source://pry-byebug//lib/pry/byebug/breakpoints.rb#9
module Pry::Byebug::Breakpoints
  extend ::Enumerable
  extend ::Pry::Byebug::Breakpoints

  # Adds a file breakpoint.
  #
  # @raise [ArgumentError]
  #
  # source://pry-byebug//lib/pry/byebug/breakpoints.rb#63
  def add_file(file, line, expression = T.unsafe(nil)); end

  # Adds a method breakpoint.
  #
  # source://pry-byebug//lib/pry/byebug/breakpoints.rb#51
  def add_method(method, expression = T.unsafe(nil)); end

  # source://pry-byebug//lib/pry/byebug/breakpoints.rb#44
  def breakpoints; end

  # Changes the conditional expression for a breakpoint.
  #
  # source://pry-byebug//lib/pry/byebug/breakpoints.rb#78
  def change(id, expression = T.unsafe(nil)); end

  # Deletes an existing breakpoint with the given ID.
  #
  # @raise [ArgumentError]
  #
  # source://pry-byebug//lib/pry/byebug/breakpoints.rb#89
  def delete(id); end

  # Deletes all breakpoints.
  #
  # source://pry-byebug//lib/pry/byebug/breakpoints.rb#100
  def delete_all; end

  # Disables a breakpoint with the given ID.
  #
  # source://pry-byebug//lib/pry/byebug/breakpoints.rb#115
  def disable(id); end

  # Disables all breakpoints.
  #
  # source://pry-byebug//lib/pry/byebug/breakpoints.rb#122
  def disable_all; end

  # source://pry-byebug//lib/pry/byebug/breakpoints.rb#136
  def each(&block); end

  # Enables a disabled breakpoint with the given ID.
  #
  # source://pry-byebug//lib/pry/byebug/breakpoints.rb#108
  def enable(id); end

  # @raise [ArgumentError]
  #
  # source://pry-byebug//lib/pry/byebug/breakpoints.rb#144
  def find_by_id(id); end

  # source://pry-byebug//lib/pry/byebug/breakpoints.rb#140
  def last; end

  # source://pry-byebug//lib/pry/byebug/breakpoints.rb#132
  def size; end

  # source://pry-byebug//lib/pry/byebug/breakpoints.rb#128
  def to_a; end

  private

  # source://pry-byebug//lib/pry/byebug/breakpoints.rb#153
  def change_status(id, enabled = T.unsafe(nil)); end

  # source://pry-byebug//lib/pry/byebug/breakpoints.rb#159
  def validate_expression(exp); end
end

# Breakpoint in a file:line location
#
# source://pry-byebug//lib/pry/byebug/breakpoints.rb#16
class Pry::Byebug::Breakpoints::FileBreakpoint < ::SimpleDelegator
  # source://pry-byebug//lib/pry/byebug/breakpoints.rb#17
  def source_code; end

  # source://pry-byebug//lib/pry/byebug/breakpoints.rb#21
  def to_s; end
end

# Breakpoint in a Class#method location
#
# source://pry-byebug//lib/pry/byebug/breakpoints.rb#29
class Pry::Byebug::Breakpoints::MethodBreakpoint < ::SimpleDelegator
  # @return [MethodBreakpoint] a new instance of MethodBreakpoint
  #
  # source://pry-byebug//lib/pry/byebug/breakpoints.rb#30
  def initialize(byebug_bp, method); end

  # source://pry-byebug//lib/pry/byebug/breakpoints.rb#35
  def source_code; end

  # source://pry-byebug//lib/pry/byebug/breakpoints.rb#39
  def to_s; end
end

Pry::Commands = T.let(T.unsafe(nil), Pry::CommandSet)
Pry::EMPTY_COMPLETIONS = T.let(T.unsafe(nil), Array)
Pry::LOCAL_RC_FILE = T.let(T.unsafe(nil), String)
Pry::VERSION = T.let(T.unsafe(nil), String)

# Main container module for Pry-Byebug functionality
#
# source://pry-byebug//lib/pry-byebug/helpers/location.rb#3
module PryByebug
  # Reference to currently running pry-remote server. Used by the processor.
  #
  # source://pry-byebug//lib/pry-byebug/base.rb#10
  def current_remote_server; end

  # Reference to currently running pry-remote server. Used by the processor.
  #
  # source://pry-byebug//lib/pry-byebug/base.rb#10
  def current_remote_server=(_arg0); end

  private

  # Ensures that a command is executed in a local file context.
  #
  # source://pry-byebug//lib/pry-byebug/base.rb#25
  def check_file_context(target, msg = T.unsafe(nil)); end

  # Checks that a target binding is in a local file context.
  #
  # source://pry-byebug//lib/pry-byebug/base.rb#17
  def file_context?(target); end

  class << self
    # Ensures that a command is executed in a local file context.
    #
    # @raise [Pry::CommandError]
    #
    # source://pry-byebug//lib/pry-byebug/base.rb#25
    def check_file_context(target, msg = T.unsafe(nil)); end

    # Checks that a target binding is in a local file context.
    #
    # @return [Boolean]
    #
    # source://pry-byebug//lib/pry-byebug/base.rb#17
    def file_context?(target); end
  end
end

# Display the current stack
#
# source://pry-byebug//lib/pry-byebug/commands/backtrace.rb#9
class PryByebug::BacktraceCommand < ::Pry::ClassCommand
  include ::PryByebug::Helpers::Navigation

  # source://pry-byebug//lib/pry-byebug/commands/backtrace.rb#23
  def process; end
end

# Add, show and remove breakpoints
#
# source://pry-byebug//lib/pry-byebug/commands/breakpoint.rb#12
class PryByebug::BreakCommand < ::Pry::ClassCommand
  include ::PryByebug::Helpers::Breakpoints
  include ::PryByebug::Helpers::Location
  include ::PryByebug::Helpers::Multiline

  # source://pry-byebug//lib/pry-byebug/commands/breakpoint.rb#50
  def options(opt); end

  # source://pry-byebug//lib/pry-byebug/commands/breakpoint.rb#62
  def process; end

  private

  # source://pry-byebug//lib/pry-byebug/commands/breakpoint.rb#111
  def add_breakpoint(place, condition); end

  # source://pry-byebug//lib/pry-byebug/commands/breakpoint.rb#93
  def new_breakpoint; end

  # source://pry-byebug//lib/pry-byebug/commands/breakpoint.rb#102
  def option_to_method(option); end

  # source://pry-byebug//lib/pry-byebug/commands/breakpoint.rb#106
  def print_all; end

  # source://pry-byebug//lib/pry-byebug/commands/breakpoint.rb#88
  def process_condition; end

  # source://pry-byebug//lib/pry-byebug/commands/breakpoint.rb#78
  def process_delete; end

  # source://pry-byebug//lib/pry-byebug/commands/breakpoint.rb#78
  def process_delete_all; end

  # source://pry-byebug//lib/pry-byebug/commands/breakpoint.rb#78
  def process_disable; end

  # source://pry-byebug//lib/pry-byebug/commands/breakpoint.rb#78
  def process_disable_all; end

  # source://pry-byebug//lib/pry-byebug/commands/breakpoint.rb#78
  def process_enable; end

  # source://pry-byebug//lib/pry-byebug/commands/breakpoint.rb#84
  def process_show; end
end

# Continue program execution until the next breakpoint
#
# source://pry-byebug//lib/pry-byebug/commands/continue.rb#11
class PryByebug::ContinueCommand < ::Pry::ClassCommand
  include ::PryByebug::Helpers::Navigation
  include ::PryByebug::Helpers::Breakpoints
  include ::PryByebug::Helpers::Location

  # source://pry-byebug//lib/pry-byebug/commands/continue.rb#31
  def process; end
end

# Travel down the frame stack
#
# source://pry-byebug//lib/pry-byebug/commands/down.rb#9
class PryByebug::DownCommand < ::Pry::ClassCommand
  include ::PryByebug::Helpers::Navigation

  # source://pry-byebug//lib/pry-byebug/commands/down.rb#27
  def process; end
end

# Exit pry REPL with Byebug.stop
#
# source://pry-byebug//lib/pry-byebug/commands/exit_all.rb#9
class PryByebug::ExitAllCommand < ::Pry::Command::ExitAll
  # source://pry-byebug//lib/pry-byebug/commands/exit_all.rb#10
  def process; end
end

# Run until the end of current frame
#
# source://pry-byebug//lib/pry-byebug/commands/finish.rb#9
class PryByebug::FinishCommand < ::Pry::ClassCommand
  include ::PryByebug::Helpers::Navigation

  # source://pry-byebug//lib/pry-byebug/commands/finish.rb#20
  def process; end
end

# Move to a specific frame in the callstack
#
# source://pry-byebug//lib/pry-byebug/commands/frame.rb#9
class PryByebug::FrameCommand < ::Pry::ClassCommand
  include ::PryByebug::Helpers::Navigation

  # source://pry-byebug//lib/pry-byebug/commands/frame.rb#27
  def process; end
end

# source://pry-byebug//lib/pry-byebug/helpers/location.rb#4
module PryByebug::Helpers; end

# Common helpers for breakpoint related commands
#
# source://pry-byebug//lib/pry-byebug/helpers/breakpoints.rb#10
module PryByebug::Helpers::Breakpoints
  # Prints a message with bold font.
  #
  # source://pry-byebug//lib/pry-byebug/helpers/breakpoints.rb#21
  def bold_puts(msg); end

  # Byebug's array of breakpoints.
  #
  # source://pry-byebug//lib/pry-byebug/helpers/breakpoints.rb#14
  def breakpoints; end

  # Max width of breakpoints id column
  #
  # source://pry-byebug//lib/pry-byebug/helpers/breakpoints.rb#77
  def max_width; end

  # Prints a header for the breakpoint list.
  #
  # source://pry-byebug//lib/pry-byebug/helpers/breakpoints.rb#63
  def print_breakpoints_header; end

  # Print out full information about a breakpoint.
  #
  # Includes surrounding code at that point.
  #
  # source://pry-byebug//lib/pry-byebug/helpers/breakpoints.rb#30
  def print_full_breakpoint(breakpoint); end

  # Print out concise information about a breakpoint.
  #
  # source://pry-byebug//lib/pry-byebug/helpers/breakpoints.rb#52
  def print_short_breakpoint(breakpoint); end
end

# Compatibility helper to handle source location
#
# source://pry-byebug//lib/pry-byebug/helpers/location.rb#8
module PryByebug::Helpers::Location
  private

  # Current file in the target binding. Used as the default breakpoint
  # location.
  #
  # source://pry-byebug//lib/pry-byebug/helpers/location.rb#15
  def current_file(source = T.unsafe(nil)); end

  class << self
    # Current file in the target binding. Used as the default breakpoint
    # location.
    #
    # source://pry-byebug//lib/pry-byebug/helpers/location.rb#15
    def current_file(source = T.unsafe(nil)); end
  end
end

# Helpers to help handling multiline inputs
#
# source://pry-byebug//lib/pry-byebug/helpers/multiline.rb#8
module PryByebug::Helpers::Multiline
  # Returns true if we are in a multiline context and, as a side effect,
  # updates the partial evaluation string with the current input.
  #
  # Returns false otherwise
  #
  # source://pry-byebug//lib/pry-byebug/helpers/multiline.rb#15
  def check_multiline_context; end
end

# Helpers to aid breaking out of the REPL loop
#
# source://pry-byebug//lib/pry-byebug/helpers/navigation.rb#8
module PryByebug::Helpers::Navigation
  # Breaks out of the REPL loop and signals tracer
  #
  # source://pry-byebug//lib/pry-byebug/helpers/navigation.rb#12
  def breakout_navigation(action, options = T.unsafe(nil)); end
end

# Run a number of lines and then stop again
#
# source://pry-byebug//lib/pry-byebug/commands/next.rb#10
class PryByebug::NextCommand < ::Pry::ClassCommand
  include ::PryByebug::Helpers::Navigation
  include ::PryByebug::Helpers::Multiline

  # source://pry-byebug//lib/pry-byebug/commands/next.rb#29
  def process; end
end

# Run a number of Ruby statements and then stop again
#
# source://pry-byebug//lib/pry-byebug/commands/step.rb#9
class PryByebug::StepCommand < ::Pry::ClassCommand
  include ::PryByebug::Helpers::Navigation

  # source://pry-byebug//lib/pry-byebug/commands/step.rb#26
  def process; end
end

# Travel up the frame stack
#
# source://pry-byebug//lib/pry-byebug/commands/up.rb#9
class PryByebug::UpCommand < ::Pry::ClassCommand
  include ::PryByebug::Helpers::Navigation

  # source://pry-byebug//lib/pry-byebug/commands/up.rb#27
  def process; end
end
