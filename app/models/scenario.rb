class Scenario
  attr_reader :id, :errors
  attr_accessor :name

  def initialize(name = nil)
    self.name = name
  end

  def self.all
    Database.execute("select name from scenarios order by name ASC").map do |row|
      scenario = Scenario.new
      scenario.name = row[0]
      scenario
    end
  end

  def self.count
    Database.execute("select count(id) from scenarios")[0][0]
  end

  def valid?
    if name.nil? or name.empty? or /^\d+$/.match(name)
      @errors = "\"#{name}\" is not a valid scenario name."
      false
    else
      @errors = nil
      true
    end
  end

  def save
    return false unless valid?
    Database.execute("INSERT INTO scenarios (name) VALUES (?)", name)
    @id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
  end
end
