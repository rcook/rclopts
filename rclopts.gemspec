lib = File.expand_path('../lib', __FILE__)
$:.unshift(lib) unless $:.include?(lib)

require 'rclopts/gem_info'

Gem::Specification.new do |s|
  s.name = 'rclopts'
  s.version = Rclopts::GemInfo.version_string
  s.date = Date.today rescue '1970-01-01'
  s.summary = 'rclopts'
  s.description = 'Ruby command-line helpers'
  s.license = 'MIT'
  s.authors = 'Richard Cook'
  s.email = 'rcook@rcook.org'
  s.files = ['LICENSE'] + Dir.glob('lib/**/*.rb')
  s.require_paths = ['lib']
  s.homepage = 'https://github.com/rcook/rclopts/'
end

