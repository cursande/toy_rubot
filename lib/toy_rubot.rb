require "toy_rubot/version"
require "toy_rubot/instruction"
require "toy_rubot/table"

module ToyRubot
  def self.run(path)
    instructions = File.readlines(path)

    instructions.reduce(Table.new) do |current_table, instruction|
      new_table = Instruction.new(instruction, current_table).process

      next new_table if new_table.valid?

      current_table
    end
  end
end
