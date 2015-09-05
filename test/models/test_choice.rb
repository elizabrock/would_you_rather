require_relative '../test_helper'

describe Choice do
  describe '.save' do
    describe 'if the model is invalid' do
      let(:choice) { Choice.new }
      it 'should return false' do
        refute choice.save
      end
      it 'should not save the model to the database' do
        choice.save
        assert_equal 0, Database.execute('SELECT count(id) FROM choices')[0][0]
      end
      it 'should populate the error messages' do # I have some qualms.
        choice.save
        assert_equal ['Selected scenario must be present.',
                      'Rejected scenario must be present.'],
                     choice.errors.full_messages
      end
    end
  end

  describe '.rejected_scenario' do
    describe 'when rejected_scenario_id has been set' do
      it 'returns the appropriate scenario' do
        scenario = Scenario.new('Eat pop tarts')
        scenario.save
        choice = Choice.new
        choice.rejected_scenario_id = scenario.id
        assert_equal scenario, choice.rejected_scenario
      end
    end
  end

  describe '.selected_scenario' do
    describe 'when selected_scenario_id has been set' do
      it 'returns the appropriate scenario' do
        scenario = Scenario.new('Eat pop tarts')
        scenario.save
        choice = Choice.new
        choice.selected_scenario_id = scenario.id
        assert_equal scenario, choice.selected_scenario
      end
    end
  end
end
