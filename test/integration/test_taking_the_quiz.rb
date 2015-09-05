require_relative '../test_helper'

class TestTakingTheQuiz < Minitest::Test
  def test_happy_path
    shell_output = ''
    expected_output = ''
    pop_tart = Scenario.new('Eat a pop tart')
    pop_tart.save
    toaster_strudel = Scenario.new('Eat a toaster strudel')
    toaster_strudel.save
    pepsi = Scenario.new('Drink Pepsi')
    pepsi.save
    diet_pepsi = Scenario.new('Drink Diet Pepsi')
    diet_pepsi.save
    IO.popen('./would_you_rather', 'r+') do |pipe|
      expected_output << "Would you rather...\n"
      expected_output << "1. Eat a pop tart\n"
      expected_output << "2. Eat a toaster strudel\n"
      pipe.puts '1'
      expected_output << "Would you rather...\n"
      expected_output << "1. Eat a pop tart\n"
      expected_output << "2. Drink Pepsi\n"
      pipe.puts '1'
      expected_output << "Would you rather...\n"
      expected_output << "1. Eat a pop tart\n"
      expected_output << "2. Drink Diet Pepsi\n"
      pipe.puts '1'
      expected_output << "Would you rather...\n"
      expected_output << "1. Eat a toaster strudel\n"
      expected_output << "2. Drink Pepsi\n"
      pipe.puts '2'
      expected_output << "Would you rather...\n"
      expected_output << "1. Eat a toaster strudel\n"
      expected_output << "2. Drink Diet Pepsi\n"
      pipe.puts '2'
      expected_output << "Would you rather...\n"
      expected_output << "1. Drink Pepsi\n"
      expected_output << "2. Drink Diet Pepsi\n"
      pipe.puts '1'
      expected_output << "That's it. Now I know you!\n"
      shell_output = pipe.read
      pipe.close_write
      pipe.close_read
    end
    assert_equal expected_output, shell_output

    choices = Choice.all
    assert_equal pop_tart, choices[0].selected_scenario
    assert_equal toaster_strudel, choices[0].rejected_scenario

    assert_equal pop_tart, choices[1].selected_scenario
    assert_equal pepsi, choices[1].rejected_scenario

    assert_equal pop_tart, choices[2].selected_scenario
    assert_equal diet_pepsi, choices[2].rejected_scenario

    assert_equal pepsi, choices[3].selected_scenario
    assert_equal toaster_strudel, choices[3].rejected_scenario

    assert_equal diet_pepsi, choices[4].selected_scenario
    assert_equal toaster_strudel, choices[4].rejected_scenario

    assert_equal pepsi, choices[5].selected_scenario
    assert_equal diet_pepsi, choices[5].rejected_scenario
  end
end
