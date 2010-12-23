#!/usr/bin/env ruby -w
require 'rubygems'
require 'irb/completion'
require 'irb/ext/save-history'

IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
IRB.conf[:AUTO_INDENT]  = true
IRB.conf[:USE_READLINE] = true

ANSI = {}
ANSI[:RESET]     = "\e[0m"
ANSI[:BOLD]      = "\e[1m"
ANSI[:UNDERLINE] = "\e[4m"
ANSI[:LGRAY]     = "\e[0;37m"
ANSI[:GRAY]      = "\e[1;30m"
ANSI[:RED]       = "\e[31m"
ANSI[:GREEN]     = "\e[32m"
ANSI[:YELLOW]    = "\e[33m"
ANSI[:BLUE]      = "\e[34m"
ANSI[:MAGENTA]   = "\e[35m"
ANSI[:CYAN]      = "\e[36m"
ANSI[:WHITE]     = "\e[37m"

# Build a simple colorful IRB prompt
IRB.conf[:PROMPT][:SIMPLE_COLOR] = {
  :PROMPT_I    => "#{ANSI[:BLUE]}>>#{ANSI[:RESET]} ",
  :PROMPT_N    => "#{ANSI[:BLUE]}>>#{ANSI[:RESET]} ",
  :PROMPT_C    => "#{ANSI[:RED]}?>#{ANSI[:RESET]} ",
  :PROMPT_S    => "#{ANSI[:YELLOW]}?>#{ANSI[:RESET]} ",
  :RETURN      => "#{ANSI[:GREEN]}=>#{ANSI[:RESET]} %s\n",
  :AUTO_INDENT => true }
IRB.conf[:PROMPT_MODE] = :SIMPLE_COLOR

# Loading extensions of the console. This is wrapped
# because some might not be included in your Gemfile
# and errors will be raised
def extend_console(name, care = true, required = true)
  if care
    require name if required
    yield if block_given?
    $console_extensions << "#{ANSI[:GREEN]}#{name}#{ANSI[:RESET]}"
  else
    $console_extensions << "#{ANSI[:GRAY]}#{name}#{ANSI[:RESET]}"
  end
rescue LoadError
  $console_extensions << "#{ANSI[:RED]}#{name}#{ANSI[:RESET]}"
end
$console_extensions = []

module ActiveRecord; end # <= required for awesome_print to work
extend_console 'ap'
extend_console 'interactive_editor'
extend_console 'wirble' do
  Wirble.init
  Wirble.colorize
end

# Show results of all extension-loading
puts "#{ANSI[:GRAY]}~> Console extensions:#{ANSI[:RESET]} #{$console_extensions.join(' ')}#{ANSI[:RESET]}"
