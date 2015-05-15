require_relative "../test_helper"

describe ScenariosController do

  describe ".index" do
    let(:controller) {ScenariosController.new}

    it "should say no scenarios found when empty" do
      actual_output = controller.index
      expected_output = "No scenarios found. Add a scenario.\n"
      assert_equal expected_output, actual_output
    end
  end

  describe ".add" do
    let(:controller) {ScenariosController.new}

    it "should add a scenario" do
      controller.add("run with scissors")
      assert_equal 1, Scenario.count
    end

    it "should not add scenario all spaces" do
      scenario_name = "       "
      result = controller.add(scenario_name)
      assert_equal "\"\" is not a valid scenario name.", result
    end

    it "should only add scenarios that make sense" do
      scenario_name = "77777777"
      controller.add(scenario_name)
      assert_equal 0, Scenario.count
    end

  end

end
