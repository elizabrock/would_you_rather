class Choice
  attr_reader :id, :errors
  attr_accessor :selected_scenario_id, :rejected_scenario_id

  def self.all
    Database.execute("select * from choices").map do |row|
      choice = Choice.new
      choice.selected_scenario_id = row['selected_scenario_id']
      choice.rejected_scenario_id = row['rejected_scenario_id']
      choice.instance_variable_set(:@id, row['id'])
      choice
    end
  end

  def initialize(attrs = {})
    self.selected_scenario_id = attrs[:selected_scenario_id]
    self.rejected_scenario_id = attrs[:rejected_scenario_id]
  end

  def save
    return false unless valid?
    Database.execute("INSERT INTO choices (rejected_scenario_id, selected_scenario_id) VALUES (?, ?)", rejected_scenario_id, selected_scenario_id)
    @id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
  end

  def valid?
    @errors = nil
    if selected_scenario_id.nil? or rejected_scenario_id.nil?
      @errors = "Both rejected_scenario_id and selected_scenario_id must be present"
    end
    @errors.nil?
  end

  def selected_scenario
    Scenario.find(self.selected_scenario_id)
  end

  def rejected_scenario
    Scenario.find(self.rejected_scenario_id)
  end
end
