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
end
