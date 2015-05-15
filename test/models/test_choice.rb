require_relative '../test_helper'

describe Choice do
  describe "#all" do
    describe "if there are no choices in the database" do
      it "should return an empty array" do
        assert_equal [], Choice.all
      end
    end
    describe "if there are scenarios" do
      before do
        Choice.new(selected_scenario_id: 1, rejected_scenario_id: 2).save
        Choice.new(selected_scenario_id: 3, rejected_scenario_id: 2).save
        Choice.new(selected_scenario_id: 1, rejected_scenario_id: 6).save
      end
      it "should return the choices in id order" do
        choices = Choice.all
        assert_equal [1, 3, 1], choices.map{ |choice| choice.selected_scenario_id }
        assert_equal [2, 2, 6], choices.map{ |choice| choice.rejected_scenario_id }
      end
    end
  end

  describe ".save" do
    describe "if the model is valid" do
      let(:choice){ Choice.new(selected_scenario_id: 2, rejected_scenario_id: 5) }
      it "should return true" do
        assert choice.save
      end
      it "should save the model to the database" do
        choice.save
        assert_equal 1, Database.execute("SELECT count(id) FROM choices")[0][0]
        last_row = Database.execute("SELECT * FROM choices")[0]
        assert_equal 2, last_row['selected_scenario_id']
        assert_equal 5, last_row['rejected_scenario_id']
      end
      it "should populate the model with id from the database" do
        choice.save
        last_row = Database.execute("SELECT * FROM choices")[0]
        database_id = last_row['id']
        assert_equal database_id, choice.id
      end
    end

    describe "if the model is invalid" do
      let(:choice){ Choice.new() }
      it "should return false" do
        refute choice.save
      end
      it "should not save the model to the database" do
        choice.save
        assert_equal 0, Database.execute("SELECT count(id) FROM choices")[0][0]
      end
      it "should populate the error messages" do # I have some qualms.
        choice.save
        assert_equal "Both rejected_scenario_id and selected_scenario_id must be present", choice.errors
      end
    end
  end

  describe ".rejected_scenario" do
    describe "when rejected_scenario_id has been set" do
      it "returns the appropriate scenario" do
        scenario = Scenario.new("Eat pop tarts")
        scenario.save
        choice = Choice.new
        choice.rejected_scenario_id = scenario.id
        assert_equal scenario, choice.rejected_scenario
      end
    end
  end

  describe ".selected_scenario" do
    describe "when selected_scenario_id has been set" do
      it "returns the appropriate scenario" do
        scenario = Scenario.new("Eat pop tarts")
        scenario.save
        choice = Choice.new
        choice.selected_scenario_id = scenario.id
        assert_equal scenario, choice.selected_scenario
      end
    end
  end
end
