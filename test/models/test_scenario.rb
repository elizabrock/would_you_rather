require_relative '../test_helper'

describe Scenario do
  describe "#all" do
    describe "if there are no scenarios in the database" do
      it "should return an empty array" do
        assert_equal [], Scenario.all
      end
    end
    describe "if there are scenarios" do
      before do
        create_scenario("Bob")
        create_scenario("Sally")
        create_scenario("Amanda")
      end
      it "should return an array" do
        # You don't need to be pedantic like this.
        # This is just an example to remind you that you can use multiple "its"
        assert_equal Array, Scenario.all.class
      end
      it "should return the scenarios in alphabetical order" do
        expected = ["Amanda", "Bob", "Sally"]
        actual = Scenario.all.map{ |scenario| scenario.name }
        assert_equal expected, actual
      end
      it "populates the returned scenarios' ids" do
        expected_ids = Database.execute("SELECT id FROM scenarios order by name ASC").map{ |row| row['id'] }
        actual_ids = Scenario.all.map{ |scenario| scenario.id }
        assert_equal expected_ids, actual_ids
      end
    end
  end

  describe "#find" do
    let(:scenario){ Scenario.new("Make pancakes") }
    before do
      scenario.save
    end
    describe "if there isn't a matching scenario in the database" do
      it "should return nil" do
        assert_equal nil, Scenario.find(14)
      end
    end
    describe "if there is a matching scenario in the database" do
      it "should return the scenario, populated with id and name" do
        actual = Scenario.find(scenario.id)
        assert_equal scenario.id, actual.id
        assert_equal scenario.name, actual.name
      end
    end
  end

  describe "equality" do
    describe "when the scenario ids are the same" do
      it "is true" do
        scenario1 = Scenario.new("foo")
        scenario1.save
        scenario2 = Scenario.all.first
        assert_equal scenario1, scenario2
      end
    end
    describe "when the scenario ids are not the same" do
      it "is true" do
        scenario1 = Scenario.new("foo")
        scenario1.save
        scenario2 = Scenario.new("foo")
        scenario2.save
        assert scenario1 != scenario2
      end
    end
  end

  describe "#count" do
    describe "if there are no scenarios in the database" do
      it "should return 0" do
        assert_equal 0, Scenario.count
      end
    end
    describe "if there are scenarios" do
      before do
        create_scenario("Bob")
        create_scenario("Sally")
        create_scenario("Amanda")
      end
      it "should return the correct count" do
        assert_equal 3, Scenario.count
      end
    end
  end

  describe ".initialize" do
    it "sets the name attribute" do
      scenario = Scenario.new("foo")
      assert_equal "foo", scenario.name
    end
  end

  describe ".save" do
    describe "if the model is valid" do
      let(:scenario){ Scenario.new("roast a pig") }
      it "should return true" do
        assert scenario.save
      end
      it "should save the model to the database" do
        scenario.save
        assert_equal 1, Scenario.count
        last_row = Database.execute("SELECT * FROM scenarios")[0]
        database_name = last_row['name']
        assert_equal "roast a pig", database_name
      end
      it "should populate the model with id from the database" do
        scenario.save
        last_row = Database.execute("SELECT * FROM scenarios")[0]
        database_id = last_row['id']
        assert_equal database_id, scenario.id
      end
    end

    describe "if the model is invalid" do
      let(:scenario){ Scenario.new("") }
      it "should return false" do
        refute scenario.save
      end
      it "should not save the model to the database" do
        scenario.save
        assert_equal 0, Scenario.count
      end
      it "should populate the error messages" do # I have some qualms.
        scenario.save
        assert_equal "\"\" is not a valid scenario name.", scenario.errors
      end
    end
  end

  describe ".valid?" do
    describe "with valid data" do
      let(:scenario){ Scenario.new("eat corn on the cob") }
      it "returns true" do
        assert scenario.valid?
      end
      it "should set errors to nil" do
        scenario.valid?
        assert scenario.errors.nil?
      end
    end
    describe "with no name" do
      let(:scenario){ Scenario.new(nil) }
      it "returns false" do
        refute scenario.valid?
      end
      it "sets the error message" do
        scenario.valid?
        assert_equal "\"\" is not a valid scenario name.", scenario.errors
      end
    end
    describe "with empty name" do
      let(:scenario){ Scenario.new("") }
      it "returns false" do
        refute scenario.valid?
      end
      it "sets the error message" do
        scenario.valid?
        assert_equal "\"\" is not a valid scenario name.", scenario.errors
      end
    end
    describe "with a name with no letter characters" do
      let(:scenario){ Scenario.new("777") }
      it "returns false" do
        refute scenario.valid?
      end
      it "sets the error message" do
        scenario.valid?
        assert_equal "\"777\" is not a valid scenario name.", scenario.errors
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
      it "should not have an error message" do
        scenario.valid?
        assert_nil scenario.errors
      end
    end
    describe ".update" do
      describe "edit previously entered scenario" do
        let(:scenario_name){ "Eat a pop tart" }
        let(:new_scenario_name){ "Eat a toaster strudel" }
        it "should update scenario name but not id" do
          skip
          scenario = Scenario.new(scenario_name)
          scenario.save
          assert_equal 1, Scenario.count
          scenario.update(scenario_name, new_scenario_name)
          last_row = Database.execute("SELECT * FROM scenarios WHERE name LIKE ?", scenario_name)[0]
          assert_equal 1, Scenario.count
          assert_equal new_scenario_name, last_row['name']
        end
      end
    end
  end
end
