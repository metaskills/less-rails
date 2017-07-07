require 'rubygems'
require 'bundler/gem_tasks'
require 'rake/testtask'
require 'appraisal'

Rake::TestTask.new do |t|
  t.libs = ['lib','test']
  t.test_files = Dir.glob("test/**/*_spec.rb").sort
  t.verbose = true
  t.warning = false
end

task :default => [:test]

desc "Setup Appraisal."
task 'appraisal:setup' do
  Rake::Task['appraisal:cleanup'].invoke
  Rake::Task['appraisal:gemfiles'].invoke
  Rake::Task['appraisal:install'].invoke
end
