# frozen_string_literal: true

require 'set'

class Day17 < Day
  DIRECTIONS = [[0, 1], [0, -1], [1, 0], [-1, 0]].freeze

  def result
    return 0 if enable_part_two

    nodes = [[0, 0, 0, 0, 0]] # row, column, delta row, delta column, line length
    visited_nodes = Set[]
    distances = { nodes.first => 0 }

    until nodes.empty?
      node = nodes.min { |node_a, node_b| distances[node_a] <=> distances[node_b] }
      nodes.delete(node)
      row, column, direction_row, direction_column, line_length = node
      node_distance = distances[node]

      DIRECTIONS.each do |direction|
        # opposite direction
        next if [direction_row * -1, direction_column * -1] == direction

        next_node_line_length = line_length
        if direction == [direction_row, direction_column]
          next_node_line_length += 1

          next if next_node_line_length > 3
        else
          next_node_line_length = 1
        end

        position = [row + direction.first, column + direction.last]
        next unless on_grid?(*position)

        next_node = [*position, *direction, next_node_line_length]
        next if visited_nodes.include?(next_node)

        distance = node_distance + grid[position[0]][position[1]]
        next_node_distance = distances[next_node]
        distances[next_node] = distance if next_node_distance.nil? || next_node_distance > distance

        nodes << next_node
      end

      visited_nodes << node
    end

    distances.select { |(row, column),| bottom_left?(row, column) }.values.min
  end

  private

  def grid
    @grid ||= @input.map.with_index do |line, row_index|
      line.chars.map { |node| node.to_i }
    end
  end

  def on_grid?(row, column)
    row >= 0 && column >= 0 && row < grid.size && column < grid.first.size
  end

  def bottom_left?(row, column)
    row == grid.size - 1 && column == grid.first.size - 1
  end
end
