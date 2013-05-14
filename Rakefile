require 'rubygems'
require 'rake/gempackagetask'
require 'rake/testtask'

spec = Gem::Specification.new do |s|
  s.name             = 'capistrano-copy_with_triggers'
  s.version          = '1.0.0'
#  s.licenses         = ['Ruby']
  s.has_rdoc         = true
  s.extra_rdoc_files = %w(README.rdoc)
  s.rdoc_options     = %w(--main README.rdoc)
  s.summary          = "A deployment strategy for Capistrano 2.0 which extends the copy strategy, adding triggers for each stage of the deploy task."
  s.authors          = ['Robin Bowes']
  s.email            = 'robin.bowes@yo61.com'
  s.homepage         = 'https://github.com/robinbowes/capistrano-copy_with_triggers'
  s.files            = %w(README.rdoc Rakefile) + Dir.glob("{lib,test}/**/*")

  s.add_dependency('capistrano', '>=2.1.0')
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList["test/**/*_test.rb"]
  t.verbose = true
end

task :default => :test
