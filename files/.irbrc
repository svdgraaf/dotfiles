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

# start wirble (with color)
if defined?(Wirble)
  Wirble.init
  Wirble.colorize
end

ARGV.concat [ "--readline", "--prompt-mode", "simple" ]
