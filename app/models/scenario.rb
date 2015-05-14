class Scenario
  attr_reader :id
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

  def save
    Database.execute("INSERT INTO scenarios (name) VALUES (?)", name)
    @id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
  end
end
