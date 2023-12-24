# frozen_string_literal: true

class Day24 < Day
  class Hailstone
    def initialize(data)
      @position, @velocity = data.split('@').map { |item| item.split(',').map(&:to_i) }
    end

    def position
      %i[x y z].map.with_index { |axis, index| [axis, @position[index]] }.to_h
    end

    def velocity
      %i[x y z].map.with_index { |axis, index| [axis, @velocity[index]] }.to_h
    end

    def intersection(hailstone)
      return [-1, -1] if coefficient.first == hailstone.coefficient.first

      x = (hailstone.coefficient.last - coefficient.last).fdiv(coefficient.first - hailstone.coefficient.first)
      y = (coefficient.first * x) + coefficient.last

      [x, y]
    end

    def time_to_reach(destination)
      (destination.first - position[:x]).fdiv(velocity[:x])
    end

    def coefficient
      [
        velocity[:y].fdiv(velocity[:x]),
        position[:y] - (position[:x] * velocity[:y]).fdiv(velocity[:x])
      ]
    end
  end

  def initialize(input, interval = (200_000_000_000_000..400_000_000_000_000), enable_part_two: false)
    @interval = interval

    super(input, enable_part_two:)
  end

  def result
    hailstones.combination(2).count do |hailstone_a, hailstone_b|
      intersection = hailstone_a.intersection(hailstone_b)
      time_a = hailstone_a.time_to_reach(intersection)
      time_b = hailstone_b.time_to_reach(intersection)

      time_a >= 0 &&
        time_b >= 0 &&
        intersection.all? { |coordinate| @interval.include?(coordinate) }
    end
  end

  private

  def hailstones
    @hailstones ||= @input.map { |line| Hailstone.new(line) }
  end
end
