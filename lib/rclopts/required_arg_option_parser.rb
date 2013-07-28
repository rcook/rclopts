require 'optparse'
require 'ostruct'
require 'set'

module Rclopts
  class RequiredArgOptionParser < OptionParser
    class RequiredArgOptionParserError < Exception; end

    def initialize
      @required_arg_names = Set.new
      super
    end

    def on_required(*args, &block)
      arg_name = nil
      args.each do |arg|
        if arg =~ /^((--\w+)(-\w+)*)/
          arg_name = $1
          break
        end
      end
      raise ArgumentError.new('Could not determine argument name') unless arg_name

      @required_arg_names << arg_name

      on *args do |options, value|
        @missing_arg_names.delete arg_name
        block.call(options, value)
      end
    end

    def on(*args, &block)
      super *args do |value|
        block.call(@options, value)
      end
    end

    def on_tail(*args, &block)
      super *args do
        block.call(@options)
      end
    end

    def process_args(args)
      @missing_arg_names = @required_arg_names.clone
      @options = OpenStruct.new
      free_args = args.clone

      begin
        parse!(free_args)
      rescue OptionParser::InvalidOption, OptionParser::MissingArgument
        message = $!.to_s + "\n\n" + self.to_s
        raise RequiredArgOptionParserError.new(message)
      end

      if !@missing_arg_names.empty?
        message = "missing required option: #{@missing_arg_names.to_a.sort.join(', ')}\n\n" + self.to_s
        raise RequiredArgOptionParserError.new(message)
      end

      [@options, free_args]
    end
  end
end

