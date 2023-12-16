# frozen_string_literal: true

class Day16 < Day
  def result
    return result_part_two if enable_part_two

    position = [0, 0] # row, column
    direction = [0, 1]
    energized_score(position, direction)
  end

  def result_part_two
    left_column = @input.first.size - 1
    bottom_row = @input.size - 1

    [
      (0..bottom_row).map do |row|
        [energized_score([row, 0], [0, 1]), energized_score([row, left_column], [0, -1])].max
      end,
      (0..left_column).map do |column|
        [energized_score([0, column], [1, 0]), energized_score([bottom_row, column], [-1, 0])].max
      end
    ].flatten.max
  end

  private

  def energized_score(position, direction)
    energized_cells = []
    beams = [[*position, *direction]]
    traced_path = []

    until beams.empty?
      beam = beams.pop

      next if traced_path.include?(beam)

      cell = beam[0..1]
      energized_cells << cell
      traced_path << beam

      direction(*beam).each do |current_direction|
        next_cell = cell.map.with_index { |coordinate, index| coordinate + current_direction[index] }
        beams.push([*next_cell, *current_direction]) if on_grid?(*next_cell)
      end
    end

    energized_cells.uniq.size
  end

  def direction(row, column, direction_row, direction_column)
    current_direction = [direction_row, direction_column]

    case @input[row][column]
    when '/'
      [current_direction.reverse.map { |element| element * -1 }]
    when '\\'
      [current_direction.reverse]
    when '-'
      [[0, 1], [0, -1]] unless current_direction.first.zero?
    when '|'
      [[1, 0], [-1, 0]] unless current_direction.last.zero?
    end || [current_direction]
  end

  def on_grid?(row, column)
    row >= 0 && column >= 0 && row < @input.size && column < @input.first.size
  end
end
