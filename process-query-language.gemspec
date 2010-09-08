# encoding: UTF-8
require File.expand_path('../lib/process-query-language/version', __FILE__)

Gem::Specification.new do |s|
  s.name         = 'process-query-language'
  s.homepage     = 'http://github.com/wereHamster/process-query-language'
  s.summary      = 'Process query language (based on plucky)'
  s.require_path = 'lib'
  s.authors      = ['Tomas Carnecky']
  s.email        = ['tomas.carnecky@gmail.com']
  s.version      = ProcessQueryLanguage::Version
  s.platform     = Gem::Platform::RUBY
  s.files        = Dir.glob("lib/**/*") + %w[LICENSE README.md]

  s.add_dependency 'plucky'
  s.add_development_dependency 'shoulda'
end
