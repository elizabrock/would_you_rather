#!/usr/bin/env ruby
# -*- ruby -*-

require 'rake/clean'
require 'rake/testtask'

task :default => :test

Rake::TestTask.new() do |config|
  config.pattern = "test/**/test_*.rb"
end

desc 'bootstrap database structure'
task :bootstrap_database do
  require_relative 'lib/database'
  Database.load_structure
end

task :import do
  require 'csv'
  require_relative 'lib/database'
  require_relative 'app/models/scenario'
  Database.load_structure
  CSV.open('fixture.csv', 'r+').each do |row|
    results = Scenario.find_by_name(row[0])
    if results.nil?
      scenario = Scenario.new(row[0])
      scenario.save
    end
  end
end
