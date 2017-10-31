# rclopts [![Install gem](https://badge.fury.io/rb/rclopts.png)](https://rubygems.org/gems/rclopts) [![Build status](https://travis-ci.org/rcook/rclopts.png)](https://travis-ci.org/rcook/rclopts)

Ruby command-line helpers

# Installation

```bash
gem install rclopts
```

# API usage

## `RequiredArgOptionParser` class

This is an enhancement of the standard Ruby `OptionParser` class which handles
required arguments in a consistent manner. It also passes an instance of
`OpenStruct` into each code block to allow code to accumulate command-line
arguments in a more natural manner than the original class allows.

```ruby
require 'rclopts'

option_parser = Rclopts::RequiredArgOptionParser.new do |p|
  p.banner = "Usage: my-command-line-tool [options]"

  p.on_required '-r VALUE', '--something-required VALUE', 'A required argument' do |o, value|
    o.something_required = value
  end

  p.on '-n VALUE', '--not-required VALUE', 'A not-required argument' do |o, value|
    o.not_required = value
  end

  p.on_tail '-h', '--help', 'Show help' do
    puts p
    exit
  end
end

begin
  options, free_args = option_parser.process_args(ARGV)
rescue Rclopts::RequiredArgOptionParser::RequiredArgOptionParserError => e
  $stderr.puts e.message
  exit 1
end

# Go about your usual business...
```

This returns an `OpenStruct` instance `options` populated with values obtained
from the command line and an array `free_args` of the free arguments passed on
the command line.

## `CliHelper` module

This class encapsulates the standard behaviour of handling parser errors,
displaying them via standard error and exiting with a nonzero return code.

You can replace

```ruby
begin
  options, free_args = option_parser.process_args(ARGV)
rescue Rclopts::RequiredArgOptionParser::RequiredArgOptionParserError => e
  $stderr.puts e.message
  exit 1
end
```

with

```ruby
options, free_args = Rclopts::CliHelper.process_args(option_parser, ARGV)
```

Easy!

# Licence

_rclopts_ is released under the MIT licence.
