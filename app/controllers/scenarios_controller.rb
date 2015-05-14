require "highline/import"

class ScenariosController
  def index
    if Scenario.count > 0
      scenarios = Scenario.all # All of the scenarios in an array
      scenarios_string = ""
      scenarios.each_with_index do |scenario, index|
        scenarios_string << "#{index + 1}. #{scenario.name}\n" #=> 1. Eat a pencil
      end
      scenarios_string
    else
      "No scenarios found. Add a scenario.\n"
    end
  end

  def add(name)
    name_cleaned = name.strip
    Scenario.create(name_cleaned)
    "\"#{name}\" has been added\n"
  end
end
