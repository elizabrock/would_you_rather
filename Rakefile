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
  require_relative 'lib/environment'
  Database.load_structure
end

task :import do
  require 'csv'
  require_relative 'lib/environment'
  Database.load_structure
  CSV.open('fixture.csv', 'r+').each do |row|
    cleaned_row = row[0].lstrip
    unless cleaned_row[0] == '#'
      results = Scenario.find_by_name(cleaned_row)
      if results.nil?
        scenario = Scenario.new(cleaned_row)
        scenario.save
      end
    end
  end
end
