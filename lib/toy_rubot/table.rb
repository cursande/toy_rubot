module ToyRubot
  class Table

    WIDTH = 6
    HEIGHT = 6

    attr_accessor :robots

    def initialize
      @width = WIDTH
      @height = HEIGHT
      @robots = {}
    end

    def valid?
      coords = @robots.values.map(&:coords)

      all_robots_in_bounds?(coords) && no_overlapping_robots?(coords)
    end

    private

    def all_robots_in_bounds?(coords)
      coords.all? do |(x, y)|
        (x >= 0 && x < @width) && (y >= 0 && y < @height)
      end
    end

    def no_overlapping_robots?(coords)
      coords == coords.uniq
    end
  end
end
