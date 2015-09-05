ENV['TEST'] = 'true'
require 'rubygems'
require 'bundler/setup'
require 'minitest/reporters'
require_relative '../lib/environment'

reporter_options = { color: true }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]

require 'minitest/autorun'
class Minitest::Test
  def setup
    Database.load_structure
    Database.execute('DELETE FROM scenarios;')
    Database.execute('DELETE FROM choices;')
  end
end

def create_scenario(name)
  Database.execute("INSERT INTO scenarios (name) VALUES (?)", name)
end

def exit_from(pipe)
  pipe.puts 'Exit'
  pipe.puts '3'
  main_menu + "Peace Out!\n"
end

def main_menu
  "1. Add a scenario\n2. List all scenarios\n3. Exit\n"
end

def actions_menu
  "Would you like to?\n1. Edit\n2. Delete\n3. Exit\n"
end
