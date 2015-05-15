class ChoicesController
  def index
    say("You would rather...\n\n")
    Choice.all.each do |choice|
      say("* #{choice.selected_scenario.name} than #{choice.rejected_scenario.name}")
    end
    say("\nNow you know yourself!")
  end

  def quiz
    scenarios = Scenario.all.sort{ |a, b| a.id <=> b.id }
    scenarios.combination(2) do |pair|
      scenarioA, scenarioB = pair
      say("Would you rather...")
      choose do |menu|
        menu.prompt = ""
        menu.choice(scenarioA.name) do
          Choice.new(selected_scenario_id: scenarioA.id,
                     rejected_scenario_id: scenarioB.id).save
        end
        menu.choice(scenarioB.name) do
          Choice.new(selected_scenario_id: scenarioB.id,
                     rejected_scenario_id: scenarioA.id).save
        end
      end
    end
    say("That's it. Now I know you!")
  end
end
