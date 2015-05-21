require_relative '../test_helper'

describe Scenario do
  describe "#all" do
    describe "if there are scenarios" do
      before do
        create_scenario("Bob")
        create_scenario("Sally")
        create_scenario("Amanda")
      end
      it "should return the scenarios in alphabetical order" do
        expected = ["Amanda", "Bob", "Sally"]
        actual = Scenario.all.map{ |scenario| scenario.name }
        assert_equal expected, actual
      end
    end
  end

  describe ".initialize" do
    it "sets the name attribute" do
      scenario = Scenario.new("foo")
      assert_equal "foo", scenario.name
    end
  end

  describe ".valid?" do
    describe "with valid data" do
      let(:scenario){ Scenario.new("eat corn on the cob") }
      it "returns true" do
        assert scenario.valid?
      end
    end
    describe "with no name" do
      let(:scenario){ Scenario.new(nil) }
      it "returns false" do
        refute scenario.valid?
      end
      it "sets the error message" do
        scenario.valid?
        assert_equal ["Name can't be blank."], scenario.errors.full_messages
      end
    end
    describe "with empty name" do
      let(:scenario){ Scenario.new("") }
      it "returns false" do
        refute scenario.valid?
      end
      it "sets the error message" do
        scenario.valid?
        assert_equal ["Name can't be blank."], scenario.errors.full_messages
      end
    end
    describe "with a name with no letter characters" do
      let(:scenario){ Scenario.new("777") }
      it "returns false" do
        refute scenario.valid?
      end
      it "sets the error message" do
        scenario.valid?
        assert_equal ["Name must contain at least 1 letter."], scenario.errors.full_messages
      end
    end
    describe "with a previously invalid name" do
      let(:scenario){ Scenario.new("666") }
      before do
        refute scenario.valid?
        scenario.name = "Eat a pop tart"
        assert_equal "Eat a pop tart", scenario.name
      end
      it "should return true" do
        assert scenario.valid?
      end
    end
  end
  describe "updating data" do
    describe "edit previously entered scenario" do
      let(:scenario_name){ "Eat a pop tart" }
      let(:new_scenario_name){ "Eat a toaster strudel" }
      it "should update scenario name but not id" do
        scenario = Scenario.new(scenario_name)
        scenario.save
        assert_equal 1, Scenario.count
        scenario.name = new_scenario_name
        assert scenario.save
        assert_equal 1, Scenario.count
        last_row = Database.execute("SELECT * FROM scenarios")[0]
        assert_equal new_scenario_name, last_row['name']
      end
      it "shouldn't update other scenarios' names" do
        bob = Scenario.new("Bob")
        bob.save
        scenario = Scenario.new(scenario_name)
        scenario.save
        assert_equal 2, Scenario.count
        scenario.name = new_scenario_name
        assert scenario.save
        assert_equal 2, Scenario.count

        bob2 = Scenario.find(bob.id)
        assert_equal bob.name, bob2.name
      end
    end
    describe "failed edit of previously entered scenario" do
      let(:scenario_name){ "Eat a pop tart" }
      let(:new_scenario_name){ "" }
      it "does not update anything" do
        scenario = Scenario.new(scenario_name)
        scenario.save
        assert_equal 1, Scenario.count
        scenario.name = new_scenario_name
        refute scenario.save
        assert_equal 1, Scenario.count
        last_row = Database.execute("SELECT * FROM scenarios")[0]
        assert_equal scenario_name, last_row['name']
      end
    end
  end
end
