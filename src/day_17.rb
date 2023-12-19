# frozen_string_literal: true

class Day17 < Day
  DIRECTIONS = [[0, 1], [0, -1], [1, 0], [-1, 0]].freeze

  class Node
    STATIONARY_NODE = [0, 0].freeze

    class << self
      attr_accessor :distances, :grid

      def [](*attrs)
        new(*attrs)
      end

      def visited=(node)
        @visited_nodes = Set[] if @visited_nodes.nil?
        @visited_nodes << node.to_a
      end

      def visited?(node)
        @visited_nodes.include?(node.to_a)
      end

      def reset
        @visited_nodes = nil
        @distances = nil
      end
    end

    def initialize(row, column, velocity = STATIONARY_NODE)
      @row = row
      @column = column
      @velocity = velocity
    end

    def <=>(other)
      distance <=> other.distance
    end

    def distance
      return if self.class.distances.nil?

      self.class.distances[to_a]
    end

    def distance=(distance)
      self.class.distances = {} if self.class.distances.nil?
      self.class.distances[to_a] = distance
    end

    def same_direction?(value)
      direction == value
    end

    def opposite_direction?(value)
      direction.map { |item| item * -1 } == value
    end

    def direction
      @velocity.map { |coordinate| coordinate.zero? ? 0 : coordinate / coordinate.abs }
    end

    def next(velocity)
      self.class.new(@row + velocity.first, @column + velocity.last, velocity)
    end

    def visited?
      self.class.visited?(self)
    end

    def value
      self.class.grid[@row][@column]
    end

    def outside_grid?
      @row.negative? ||
        @column.negative? ||
        @row >= self.class.grid.size ||
        @column >= self.class.grid.first.size
    end

    def to_a
      [@row, @column, *direction]
    end
  end

  def result
    max_line_length = 3
    turn_after = 1

    if enable_part_two
      max_line_length = 10
      turn_after = 4
    end

    Node.reset
    Node.grid = @input.map { |line| line.chars.map(&:to_i) }
    nodes = [Node[0, 0]]
    nodes.first.distance = 0

    until nodes.empty?
      node = nodes.min
      Node.visited = nodes.delete(node)

      DIRECTIONS.each do |direction|
        next if node.same_direction?(direction) || node.opposite_direction?(direction)

        (turn_after..max_line_length).each do |line_length|
          next_node = node.next(direction.map { |coordinate| coordinate * line_length })
          next if next_node.outside_grid? || next_node.visited?

          distance =
            line_length.times.sum do |length|
              node.next(direction.map { |coordinate| coordinate * (length + 1) }).value
            end + node.distance

          next_node.distance = distance if next_node.distance.nil? || next_node.distance > distance

          nodes << next_node if nodes.index { |queued_node| queued_node.to_a == next_node.to_a }.nil?
        end
      end
    end

    Node.distances.select { |(node_row, node_column),| bottom_left?(node_row, node_column) }.values.min
  end

  private

  def bottom_left?(row, column)
    row == Node.grid.size - 1 && column == Node.grid.first.size - 1
  end
end
