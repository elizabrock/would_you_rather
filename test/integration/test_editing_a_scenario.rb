require_relative '../test_helper'

=begin
Usage Example:

  > ./would_you_rather manage
  1. Add a scenario
  2. List all scenarios
  3. Exit
  > 2
  1. eat a snake
  2. eat a steak
  3. butcher a cow
  > 2
  Would you like to?
  1. Edit
  2. Delete
  3. Exit
  > 1
  Enter a new name:
  > Eat a pop tart
  "eat a steak" was renamed to "Eat a pop tart"
  1. Add a scenario
  2. List all scenarios
  3. Exit
  > 3
  Peace Out!
=end

## TODO: Add Acceptance criteria to this file.

class EditingAScenarioTest < Minitest::Test

  def test_user_left_scenarios_unchanged
    shell_output = ""
    expected_output = main_menu
    test_scenario = "run with scissors"
    Scenario.new(test_scenario).save
    IO.popen('./would_you_rather manage', 'r+') do |pipe|
      pipe.puts "2" # List
      expected_output << "1. #{test_scenario}\n"
      expected_output << "2. Exit\n"
      pipe.puts "1"
      expected_output << actions_menu
      pipe.puts "3" # Exit
      shell_output = pipe.read
      pipe.close_write
      pipe.close_read
    end
    assert_equal expected_output, shell_output
  end

  def test_happy_path_editing_a_scenario
    shell_output = ""
    expected_output = main_menu
    test_scenario = "run with scissors"
    scenario = Scenario.new(test_scenario)
    scenario.save
    IO.popen('./would_you_rather manage', 'r+') do |pipe|
      pipe.puts "2" # List
      expected_output << "1. #{test_scenario}\n"
      expected_output << "2. Exit\n"
      pipe.puts "1"
      expected_output << actions_menu
      pipe.puts "1" # Edit
      expected_output << "Enter a new name:\n"
      pipe.puts "Eat a pop tart"
      expected_output << "Scenario has been updated to: \"Eat a pop tart\"\n"
      expected_output << main_menu
      pipe.puts "3" # Exit
      expected_output << "Peace Out!\n"
      shell_output = pipe.read
      pipe.close_write
      pipe.close_read
    end
    assert_equal expected_output, shell_output
    new_name = Scenario.find(scenario.id).name
    assert_equal "Eat a pop tart", new_name
  end

  def test_sad_path_editing_a_scenario
    shell_output = ""
    expected_output = main_menu
    test_scenario = "run with scissors"
    scenario = Scenario.new(test_scenario)
    scenario.save
    IO.popen('./would_you_rather manage', 'r+') do |pipe|
      pipe.puts "2" # List
      expected_output << "1. #{test_scenario}\n"
      expected_output << "2. Exit\n"
      pipe.puts "1"
      expected_output << actions_menu
      pipe.puts "1" # Edit
      expected_output << "Enter a new name:\n"
      pipe.puts ""
      expected_output << "\"\" is not a valid scenario name.\n"
      expected_output << "Enter a new name:\n"
      pipe.puts "Eat a pop tart"
      expected_output << "Scenario has been updated to: \"Eat a pop tart\"\n"
      expected_output << main_menu
      pipe.puts "3" # Exit
      expected_output << "Peace Out!\n"
      shell_output = pipe.read
      pipe.close_write
      pipe.close_read
    end
    assert_equal expected_output, shell_output
    new_name = Scenario.find(scenario.id).name
    assert_equal "Eat a pop tart", new_name
  end

end
