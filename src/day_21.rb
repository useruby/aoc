# frozen_string_literal: true

class Day21 < Day
  DIRECTIONS = [[0, 1], [0, -1], [1, 0], [-1, 0]].freeze

  def initialize(input, steps = nil, enable_part_two: false)
    super(input, enable_part_two:)

    @steps = steps || (enable_part_two ? 26_501_365 : 64)
    @map = load_map
  end

  def result
    elf_positions = [@start]
    @steps.times { |_step_count| elf_positions = possible_moves(elf_positions) }

    elf_positions.size
  end

  private

  def possible_moves(positions)
    positions.flat_map do |row, col|
      DIRECTIONS.filter_map do |direction_row, direction_col|
        position = [row + direction_row, col + direction_col]
        position if can_walk?(*position)
      end.compact
    end.uniq
  end

  def can_walk?(row, col)
    if row.negative? || col.negative? || row >= @map.size || col >= @map.first.size
      row %= @map.size
      col %= @map.first.size
    end

    @map[row][col]
  end

  def load_map
    @input.map.with_index do |row, row_index|
      row.chars.map.with_index do |tile, col_index|
        @start = [row_index, col_index] if tile == 'S'
        %(S .).include?(tile)
      end
    end
  end
end
