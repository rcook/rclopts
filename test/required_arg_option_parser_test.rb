require_relative 'test_helper'

module RcloptsTest
  class RequiredArgOptionParserTest < Test::Unit::TestCase
    def test_run_required_args
      option_parser = Rclopts::RequiredArgOptionParser.new do |p|
        p.on_required '--my-required-arg VALUE' do |o, value|
          o.my_required_arg = value
        end
      end

      options, free_args = option_parser.process_args(['--my-required-arg', 'THE-VALUE', 'first', 'second', 'third'])
      assert_equal 'THE-VALUE', options.my_required_arg
      assert_equal ['first', 'second', 'third'], free_args

      assert_raise Rclopts::RequiredArgOptionParser::RequiredArgOptionParserError do
        option_parser.process_args(['first', 'second', 'third'])
      end
    end
  end
end

