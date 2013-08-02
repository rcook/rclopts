if RUBY_VERSION < '1.9.0'
  require File.expand_path('../rclopts/cli_helper', __FILE__)
  require File.expand_path('../rclopts/gem_info', __FILE__)
  require File.expand_path('../rclopts/required_arg_option_parser', __FILE__)
else
  require_relative 'rclopts/cli_helper'
  require_relative 'rclopts/gem_info'
  require_relative 'rclopts/required_arg_option_parser'
end

