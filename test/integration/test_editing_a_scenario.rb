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
    skip
    shell_output = ""
    expected_output = main_menu
    test_scenario = "run with scissors"
    IO.popen('./would_you_rather manage', 'r+') do |pipe|
      pipe.puts "2"
      expected_output << "What scenario would you like to add?\n"
      pipe.puts test_scenario
      expected_output << "\"#{test_scenario}\" has been added\n"
      expected_output << main_menu
      pipe.puts "2"
      expected_output << "1. #{test_scenario}\n"
      pipe.puts "1"
      expected_output << actions_menu
      pipe.puts "3"
      expected_output << main_menu
      shell_output = pipe.read
      pipe.close_write
      pipe.close_read
    end
    assert_equal expected_output, shell_output
  end

  def test_happy_path_editing_a_scenario
    skip("WIP")
  end

  def test_sad_path_editing_a_scenario
    skip("WIP")
  end

end
