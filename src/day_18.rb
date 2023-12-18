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
      @digger = [0, 0]
      @path = [@digger]
      @directions = DIRECTIONS.to_h.freeze
    end

    def digging(steps, direction)
      velocity = @directions[direction]

      @path << @digger = [
        @digger.first + (velocity.first * steps),
        @digger.last + (velocity.last * steps)
      ]
    end
  end

  def result
    digging_sequence =
      if enable_part_two
        @input.map do |line|
          _, _, hex_number = line.split
          match = hex_number.match(/\(\#(?<steps>[0-9a-f]{5})(?<direction>[0-9a-f]{1})\)/)
          [Lagoon::DIRECTIONS[match[:direction].to_i(16)].first, match[:steps].to_i(16)]
        end
      else
        @input.map do |line|
          direction, steps, = line.split
          [direction, steps.to_i]
        end
      end

    calculate_lagoon_square(digging_sequence)
  end

  def calculate_lagoon_square(digging_sequence)
    lagoon = Lagoon.new
    tranch_size = 0

    digging_sequence.each do |direction, steps|
      lagoon.digging(steps, direction)
      tranch_size += steps
    end

    path_row_coordinates, path_col_coordinates = lagoon.path.transpose

    ((
      path_col_coordinates[0..-2].zip(path_row_coordinates[1..]).sum { |row, col| row * col } -
      path_row_coordinates[0..-2].zip(path_col_coordinates[1..]).sum { |col, row| row * col }
    ).abs / 2) + (tranch_size / 2) + 1
  end
end
