#!/usr/bin/env ruby -w

# attempt to load some libraries
def prefer(lib)
  require lib
rescue LoadError
  puts "Could not load #{lib}"
end

# load libraries
prefer 'rubygems'
prefer 'wirble'
prefer 'irb/completion'
IRB.conf[:AUTO_INDENT] = true


ARGV.concat [ "--readline", "--prompt-mode", "simple" ]



# Loading extensions of the console. This is wrapped
# because some might not be included in your Gemfile
# and errors will be raised
def extend_console(name, care = true, required = true)
  if care
    require name if required
    yield if block_given?
    $console_extensions << name
  else
    $console_extensions << name
  end
rescue LoadError
  $console_extensions << name
end
$console_extensions = []

# Wirble is a gem that handles coloring the IRB
# output and history
extend_console 'wirble' do
  Wirble.init
  Wirble.colorize
end

# awesome_print is prints prettier than pretty_print
extend_console 'ap' do
  alias pp ap
end
