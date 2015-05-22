class Choice < ActiveRecord::Base
  validates :selected_scenario_id, :rejected_scenario_id, presence: { message: "must be present." }

  belongs_to :rejected_scenario, class_name: "Scenario"
  belongs_to :selected_scenario, class_name: "Scenario"
end
