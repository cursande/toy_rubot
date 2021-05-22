# ToyRubot

This is an implementation of the Toy Robot challenge in Ruby. 
It comes with the added condition that there can be multiple named robots on the board at a given time.

## Running the simulation
``` shell
bundle exec bin/toy_rubot example_input.txt
```

## Testing
from the project root, run the following:
``` shell
bundle exec rspec
```

## Approach

- Opted to use small, simple objects given the constraints of the problem.

- State is centralised on table objects. Based on the robots on the table at a given time, the table can determine if it is valid or not (no overlapping robots, none have crossed the edge of the table). The trade-off for this simplicity is that we end up checking robots that have not moved between valid commands. For our case this is not an issue, but as a general approach it would be problematic in performance-sensitive contexts.

- All that's needed to return a new state of the table, is the current table along with the next instruction to be run

- Decided against modelling robots as discrete message receivers as there seemed to be minimal clarity or benefit from it. Instead they are modelled as key-value pairs (name => position).

- The main test ensures it works end-to-end with a given file, while permutations of individual commands can be tested in the unit tests.

- The intruction object is intended to capture the name and command together.

- With more time, there would be value in refactoring instructions, and how they interact with the table. Given that the logic to validate the table lives outside instructions, the coupling
between the table and the instruction is unecessary. It would be better to separate these abstractions properly so that instructions only deal with the robot the new command applies to, and the action it needs to take.
