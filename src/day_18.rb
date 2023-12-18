# frozen_string_literal: true

class Day18 < Day
  class Lagoon
    DIRECTIONS = {
      'R' => [0, 1],
      'L' => [0, -1],
      'D' => [1, 0],
      'U' => [-1, 0]
    }.freeze

    def initialize
      @digger = [0, 0]
      @path = [@digger]
    end

    def digging(direction)
      velocity = DIRECTIONS[direction]
      @digger = [@digger.first + velocity.first, @digger.last + velocity.last]
      @path << @digger
    end

    def dig_out_interior
      create_grid

      result_grid = Array.new(@grid.size) { +'' }

      @grid.each_with_index do |line, line_index|
        line.chars.map.with_index do |cell, index|
          result_grid[line_index][index] = cell
          next unless cell == '.'

          result_grid[line_index][index] = '#' if intersections(line, line_index, index).odd?
        end
      end

      @grid = result_grid
      # @grid.each { |line| puts line }
    end

    def dig_out_size
      @grid.sum { |line| line.scan('#').size }
    end

    private

    def create_grid
      normalize_path
      bottom_right = [0, 0]

      @path[1..].each do |coordinate|
        bottom_right = [
          [bottom_right.first, coordinate.first].max,
          [bottom_right.last, coordinate.last].max
        ]
      end

      @grid = Array.new(bottom_right.first + 1) { '.' * (bottom_right.last + 1) }
      @path.each { |coordinate| @grid[coordinate.first][coordinate.last] = '#' }
    end

    def normalize_path
      top_left = [0, 0]

      @path[1..].each do |coordinate|
        top_left = [
          [top_left.first, coordinate.first].min,
          [top_left.last, coordinate.last].min
        ]
      end

      top_left.map!(&:abs)
      @path.map! { |coordinate| [coordinate.first + top_left.first, coordinate.last + top_left.last] }
    end

    def intersections(line, row, column)
      return 0 if row.zero? || row == (@grid.size - 1)

      intersections = line[column..].split('.').count { |item| !item.empty? && item.size <= 2 }

      loop do
        left_corner = line.index(/\#{2,}/, column)

        return intersections if left_corner.nil?

        right_corner = line.index('.', left_corner)
        right_corner = line.size if right_corner.nil?
        right_corner -= 1
        column = right_corner

        # binding.break if line == '###.###'

        intersections += if (@grid[row - 1][left_corner] == '#') ^ (@grid[row - 1][right_corner] == '#')
                           1
                         else
                           2
                         end
      end
    end
  end

  def result
    return 0 if enable_part_two

    lagoon = Lagoon.new

    @input.each do |line|
      direction, steps, = line.split

      steps.to_i.times { lagoon.digging(direction) }
    end

    lagoon.dig_out_interior
    lagoon.dig_out_size
  end
end
