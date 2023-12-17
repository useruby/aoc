# frozen_string_literal: true

require 'set'

class Day17 < Day
  DIRECTIONS = [[0, 1], [0, -1], [1, 0], [-1, 0]].freeze

  def result
    max_line_length = 3
    turn_after = 1

    if enable_part_two
      max_line_length = 10
      turn_after = 4
    end

    nodes = [[0, 0, 0, 0]] # row, column, delta row, delta column
    visited_nodes = Set[]
    distances = { nodes.first => 0 }

    until nodes.empty?
      node = nodes.min { |node_a, node_b| distances[node_a] <=> distances[node_b] }
      nodes.delete(node)
      row, column, direction_row, direction_column = node
      node_distance = distances[node]

      DIRECTIONS.each do |direction|
        # same direction
        next if direction == [direction_row, direction_column]
        # opposite direction
        next if direction == [direction_row * -1, direction_column * -1]

        (turn_after..max_line_length).each do |line_length|
          position = [row + (direction.first * line_length), column + (direction.last * line_length)]
          next unless on_grid?(*position)

          next_node = [*position, *direction]
          next if visited_nodes.include?(next_node)

          distance = node_distance
          line_length.times do |length|
            distance += grid[row + (direction.first * (length + 1))][column + (direction.last * (length + 1))]
          end

          next_node_distance = distances[next_node]
          distances[next_node] = distance if next_node_distance.nil? || next_node_distance > distance

          nodes << next_node
        end
      end

      visited_nodes << node
    end

    distances.select { |(node_row, node_column),| bottom_left?(node_row, node_column) }.values.min
  end

  private

  def grid
    @grid ||= @input.map.with_index do |line, _row_index|
      line.chars.map(&:to_i)
    end
  end

  def on_grid?(row, column)
    row >= 0 && column >= 0 && row < grid.size && column < grid.first.size
  end

  def bottom_left?(row, column)
    row == grid.size - 1 && column == grid.first.size - 1
  end
end
