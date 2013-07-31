if RUBY_VERSION < '1.9.0'
  require File.expand_path('../rclopts/required_arg_option_parser', __FILE__)
else
  require_relative 'rclopts/required_arg_option_parser'
end

