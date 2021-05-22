module ToyRubot
  class Instruction

    DIRECTIONS = {
      'LEFT' => {
        'NORTH' => 'WEST',
        'WEST' => 'SOUTH',
        'SOUTH' => 'EAST',
        'EAST' => 'NORTH'
      },
      'RIGHT' => {
        'NORTH' => 'EAST',
        'EAST' => 'SOUTH',
        'SOUTH' => 'WEST',
        'WEST' => 'NORTH'
      }
    }

    MOVEMENT_OFFSETS = {
      'NORTH' => [0, 1],
      'EAST' => [1, 0],
      'SOUTH' => [0, -1],
      'WEST' => [-1, 0]
    }

    PLACE_PATTERN = /PLACE (?<x>\d+),(?<y>\d+),(?<direction>NORTH|SOUTH|EAST|WEST)/

    def initialize(instruction, table)
      (name, command) = instruction.split(': ')
      @name = name
      @command = command.chomp
      @current_position = table.robots[name]
      @current_table = table
      @new_table = Table.new
    end

    def process
      type = @command.split.first

      return @current_table if command_not_possible?(type)

      new_position = handle_command(type)
      @new_table.robots = @current_table.robots.merge({ @name => new_position })
      @new_table
    end

    private

    def handle_command(type)
      case type
      when 'PLACE' then place
      when 'MOVE' then move
      when 'LEFT','RIGHT' then turn
      when 'REPORT' then report
      end
    end

    def command_not_possible?(type)
      @current_position.nil? && type != 'PLACE'
    end

    def place
      parsed = @command.match(PLACE_PATTERN)

      RobotPosition.new(
        [parsed[:x].to_i, parsed[:y].to_i],
        parsed[:direction]
      )
    end

    def move
      (x, y) = @current_position.coords
      (x_offset, y_offset) = MOVEMENT_OFFSETS.fetch(@current_position.direction)

      RobotPosition.new(
        [x + x_offset, y + y_offset],
        @current_position.direction
      )
    end

    def turn
      new_direction = DIRECTIONS[@command][@current_position.direction]

      RobotPosition.new(@current_position.coords, new_direction)
    end

    def report
      (x, y) = @current_position.coords

      puts "#{@name}: #{x},#{y},#{@current_position.direction}"

      @current_position
    end
  end
end
