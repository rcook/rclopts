module Rclopts
  module CliHelper
    def self.process_args(option_parser, args)
      begin
        options, free_args = option_parser.process_args(args)
      rescue Rclopts::RequiredArgOptionParser::RequiredArgOptionParserError => e
        $stderr.puts e.message
        exit 1
      end
      [options, free_args]
    end
  end
end

