# Would You Rather?

Cohort Huckleberry Ruby Capstone Project

## Project Vision

This will be a small command-line program that asks the user to rank what (of two scenarios) they'd rather do.

Users will be able to add/edit/delete scenarios, as well as take a quiz to make choices between the scenarios.  After taking the quiz, the user can get a list of the things they'd rather do based on the results of their quiz.

## Usage

 * Run `rake bootstrap_database` to setup your local database
 * Then, `./would_you_rather manage` to manage the list of scenarios.

### Viewing quiz results

In order to learn hard truths about my life priorities
I want to see what my priorities, as reflected by my quiz answer

(Given the quiz below)

    > ./would_you_rather results

    You would rather...

    * Eat a pop tart than Eat a toaster strudel
    * Drink Pepsi than Eat a toaster strudel
    * Drink Pepsi than Drink Diet Pepsi

    Now you know yourself!


### Taking the quiz

In order to learn hard truths about my life priorities
I want to take the quiz

Assuming there are the following scenarios:

  * Eat a pop tart
  * Eat a toaster strudel
  * Drink Pepsi
  * Drink Diet Pepsi

    > ./would_you_rather
    Would you rather...
    1. Eat a pop tart
    2. Eat a toaster strudel
    > 1
    Would you rather...
    1. Eat a toaster strudel
    2. Drink Pepsi
    > 2
    Would you rather...
    1. Drink Pepsi
    2. Drink Diet Pepsi
    > 1
    That's it.  Now I know you!

The results would then be printed out.

### Adding a new scenario

In order to have illuminating connections in our quiz results
I want to add many scenarios

Usage Example:

    > ./would_you_rather manage
    1. Add a scenario
    2. List all scenarios
    3. Exit
    > 1
    What scenario would you like to add?
    > butcher a cow
    "butcher a cow" has been added
    1. Add a scenario
    2. List all scenarios
    3. Exit

Acceptance Criteria:

  * Program prints out confirmation that the scenario was added
  * The scenario is added to the database
  * After being added, the scenario will be visible via. "List all scenarios", once that feature has been implemented
  * After the addition, the user is taken back to the main manage menu

### Editing an existing scenario

In order to fix typos and/or clarify meaning
I want to edit an existing scenario

Usage Example:
    > ./would_you_rather manage
    1. Add a scenario
    2. List all scenarios
    3. Exit
    > 2
    1. eat a snake
    2. eat a steak
    3. butcher a cow
    > 2
    Would you like to?
    1. Edit
    2. Delete
    3. Exit
    > 1
    Enter a new name:
    > Eat a pop tart
    Scenario has been updated to: "Eat a pop tart"
    1. Add a scenario
    2. List all scenarios
    3. Exit
    > 3
    Peace Out!

Acceptance Criteria:

    * User should be able select proper scenario using a scenario's number.
    * After selecting a scenario, User should be presented with a submenu containing possible actions.
    * Once the user enters a new name, show confirmation of the renaming.
    * On rename, if the user input is invalid, then ask the user to enter a valid name.
    * After confirmation of scenario renaming, show the main menu.

### Viewing all existing scenarios

In order to evaluate and/or manage the existing scenarios
I want to view all the existing scenarios

Usage Example:

    > ./would_you_rather manage
    1. Add a scenario
    2. List all scenarios
    3. Exit
    > 2
    1. eat a snake
    2. eat a steak
    3. butcher a cow

Acceptance Criteria:

  * All scenarios are printed out
  * Each scenario is given a number, which does not correspond to its database id

### Deleting a scenario

In order to remove duplicates and/or scenarios that aren't illuminating
I want to delete an existing scenario

Usage Example:

    > ./would_you_rather manage
    1. Add a scenario
    2. List all scenarios
    3. Exit
    > 2
    1. eat a snake
    2. eat a steak
    3. butcher a cow
    > 3
    butcher a cow
    Would you like to?
    1. Edit
    2. Delete
    3. Exit
    > 2
    "butcher a cow" has been deleted
    1. Add a scenario
    2. List all scenarios
    3. Exit

Acceptance Criteria:

  * Program prints out confirmation that the scenario was deleted.
  * The deleted scenario is removed from the database.
  * All references to the deleted scenario are removed from the database.
  * After the deletion, the user is taken back to the main manage menu.

### Importing baseline scenarios

In order to avoid having to come up with my own scenarios
I want to import an existing list of scenarios
