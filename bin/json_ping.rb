#!/usr/bin/env ruby
$:.unshift(File.dirname(__FILE__) + '/../lib') unless $:.include?(File.dirname(__FILE__) + '/../lib')

require 'ping_parser_unix'

ping_cmd = "ping -q -c 10 google.com"
ping_output = `#{ping_cmd}`

ping_result = PingParserUnix.parse(ping_output)
puts ping_result.to_json
