#!/usr/bin/env ruby -w

require("tempfile")
PASTE_URL = (ENV["PASTIE_URL"] or "http://pastie.caboo.se/pastes/create")
if ENV["FILE"] then
  text = File.open(File.expand_path(ENV["FILE"]), "r") { |f| f.read }
end
text ||= STDIN.read
text_file = Tempfile.open("w+")
(text_file << text)
text_file.flush
cmd = "curl #{PASTE_URL} -s -L -o /dev/null -w \"%{url_effective}\" -H \"Expect:\" -F \"paste[parser]=ruby\" -F \"paste[restricted]=1\" -F \"paste[authorization]=burger\" -F \"paste[body]=<#{text_file.path}\" -F \"key=\" -F \"x=27\" -F \"y=27\"\n"
out = `\n #{cmd}\n `
text_file.close(true)
puts(out)
