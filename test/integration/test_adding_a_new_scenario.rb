require_relative '../test_helper'

# In order to have illuminating connections in our quiz results
# I want to add many scenarios

# Usage Example:

#   > ./would_you_rather manage
#   1. Add a scenario
#   2. List all scenarios
#   3. Exit
#   > 1
#   What scenario would you like to add?
#   > butcher a cow
#   "butcher a cow" has been added
#   1. Add a scenario
#   2. List all scenarios
#   3. Exit

# Acceptance Criteria:

#   * Program prints out confirmation that the scenario was added.
#   * The scenario is added to the database.
#   * After being added, the scenario will be visible via. "List all scenarios",
#     once that feature has been implemented.
#   * After the addition, the user is taken back to the main manage menu.

class AddingANewScenarioTest < Minitest::Test
  def test_happy_path_adding_a_scenario
    shell_output = ''
    expected_output = main_menu
    test_scenario = 'run with scissors'
    IO.popen('./would_you_rather manage', 'r+') do |pipe|
      pipe.puts '1'
      expected_output << "What scenario would you like to add?\n"
      pipe.puts test_scenario
      expected_output << "\"#{test_scenario}\" has been added\n"
      expected_output << main_menu
      pipe.puts '2'
      expected_output << "1. #{test_scenario}\n"
      expected_output << "2. Exit\n"
      expected_output << exit_from(pipe)
      shell_output = pipe.read
      pipe.close_write
      pipe.close_read
    end
    assert_equal expected_output, shell_output
  end

  def test_sad_path_adding_a_scenario
    shell_output = ''
    happy_scenario = 'running with a knife'
    expected_output = main_menu
    IO.popen('./would_you_rather manage', 'r+') do |pipe|
      pipe.puts '1'
      expected_output << "What scenario would you like to add?\n"
      pipe.puts ''
      expected_output << "Name can't be blank.\n"
      expected_output << "What scenario would you like to add?\n"
      pipe.puts happy_scenario
      expected_output << "\"#{happy_scenario}\" has been added\n"
      expected_output << main_menu
      pipe.puts '2'
      expected_output << "1. #{happy_scenario}\n"
      expected_output << "2. Exit\n"
      expected_output << exit_from(pipe)
      shell_output = pipe.read
      pipe.close_write
      pipe.close_read
    end
    assert_equal expected_output, shell_output
  end
end
