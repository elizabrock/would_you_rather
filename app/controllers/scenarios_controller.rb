require 'highline/import'

class ScenariosController
  def index
    if Scenario.count > 0
      scenarios = Scenario.all # All of the scenarios in an array
      choose do |menu|
        menu.prompt = ''
        scenarios.each do |scenario|
          menu.choice(scenario.name) { action_menu(scenario) }
        end
        menu.choice('Exit')
      end
    else
      say("No scenarios found. Add a scenario.\n")
    end
  end

  def action_menu(scenario)
    say('Would you like to?')
    choose do |menu|
      menu.prompt = ''
      menu.choice('Edit') do
        edit(scenario)
      end
      menu.choice('Delete') do
        # destroy(scenario)
        puts 'This feature has not yet been implemented.'
      end
      menu.choice('Exit') do
        exit
      end
    end
  end

  def add(name)
    scenario = Scenario.new(name.strip)
    if scenario.save
      "\"#{name}\" has been added\n"
    else
      scenario.errors.full_messages.join
    end
  end

  def edit(scenario)
    loop do
      user_input = ask('Enter a new name:')
      scenario.name = user_input.strip
      if scenario.save
        say("Scenario has been updated to: \"#{scenario.name}\"")
        return
      else
        say(scenario.errors.full_messages.join)
      end
    end
  end
end
