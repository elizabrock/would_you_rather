require_relative '../test_helper'

class TestQuizResults < Minitest::Test
  def test_happy_path
    pop_tart = Scenario.new('Eat a pop tart')
    pop_tart.save
    toaster_strudel = Scenario.new('Eat a toaster strudel')
    toaster_strudel.save
    pepsi = Scenario.new('Drink Pepsi')
    pepsi.save
    diet_pepsi = Scenario.new('Drink Diet Pepsi')
    diet_pepsi.save

    Choice.new(rejected_scenario_id: toaster_strudel.id,
               selected_scenario_id: pop_tart.id).save
    Choice.new(rejected_scenario_id: toaster_strudel.id,
               selected_scenario_id: pepsi.id).save
    Choice.new(rejected_scenario_id: diet_pepsi.id,
               selected_scenario_id: pepsi.id).save

    output = `./would_you_rather results`
    expected = <<EOS
You would rather...

* Eat a pop tart than Eat a toaster strudel
* Drink Pepsi than Eat a toaster strudel
* Drink Pepsi than Drink Diet Pepsi

Now you know yourself!
EOS
    assert_equal expected, output
  end
end
