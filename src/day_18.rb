# frozen_string_literal: true

class Day18 < Day
  class Lagoon
    DIRECTIONS = [
      ['R', [0, 1]],
      ['D', [1, 0]],
      ['L', [0, -1]],
      ['U', [-1, 0]]
    ].freeze

    attr_reader :path

    def initialize
      @path = [[0, 0]]
      @directions = DIRECTIONS.to_h.freeze
    end

    def digging(steps, direction)
      @path << @path.last.zip(@directions[direction]).map { |position, velocity| position + (steps * velocity) }
    end
  end

  def result
    calculate_lagoon_area(
      enable_part_two ? digging_sequence_part_two : digging_sequence_part_one
    )
  end

  def digging_sequence_part_one
    @input.map do |line|
      direction, steps, = line.split
      [direction, steps.to_i]
    end
  end

  def digging_sequence_part_two
    @input.map do |line|
      _, _, hex_number = line.split
      match = hex_number.match(/\(\#(?<steps>[0-9a-f]{5})(?<direction>[0-9a-f]{1})\)/)
      [Lagoon::DIRECTIONS[match[:direction].to_i(16)].first, match[:steps].to_i(16)]
    end
  end

  def calculate_lagoon_area(digging_sequence)
    lagoon = Lagoon.new

    tranch_size = digging_sequence.sum do |direction, steps|
      lagoon.digging(steps, direction)
      steps
    end

    xn, yn = lagoon.path.transpose
    ((xn[0..-2].zip(yn[1..]).sum { |x, y| x * y } - yn[0..-2].zip(xn[1..]).sum { |y, x| x * y }).abs / 2) +
      (tranch_size / 2) + 1
  end
end
