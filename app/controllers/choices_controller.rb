class ChoicesController
  def index
    say("You would rather...\n\n")
    Choice.all.each do |choice|
      say("* #{choice.selected_scenario.name} than #{choice.rejected_scenario.name}")
    end
    say("\nNow you know yourself!")
  end

  def quiz
    scenarios = Scenario.all.sort { |a, b| a.id <=> b.id }
    scenarios.combination(2) do |pair|
      scenario_a, scenario_b = pair
      say('Would you rather...')
      choose do |menu|
        menu.prompt = ''
        menu.choice(scenario_a.name) do
          Choice.new(selected_scenario_id: scenario_a.id,
                     rejected_scenario_id: scenario_b.id).save
        end
        menu.choice(scenario_b.name) do
          Choice.new(selected_scenario_id: scenario_b.id,
                     rejected_scenario_id: scenario_a.id).save
        end
      end
    end
    say("That's it. Now I know you!")
  end
end
