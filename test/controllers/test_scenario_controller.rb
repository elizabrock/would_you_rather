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

  end

end
