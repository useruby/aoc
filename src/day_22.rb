# frozen_string_literal: true

require 'debug'

class Day22 < Day
  class Brick
    attr_reader :label

    def initialize(data, label)
      @label = label

      return if data.nil?

      @coordinates_one, @coordinates_two = data.split('~').map { |coordinates| coordinates.split(',').map(&:to_i) }
    end

    %i[x y z].each_with_index do |axie, index|
      define_method(axie) do
        (@coordinates_one[index]..@coordinates_two[index])
      end
    end
  end

  GROUND = Brick.new(nil, 'ground').freeze

  def result
    filled_cubes = {}
    supports = {}

    bricks.each do |brick|
      z_offset = 0

      support_bricks = loop do
        support_bricks = find_support(brick, filled_cubes, z_offset + 1)

        break support_bricks unless support_bricks.empty?

        z_offset += 1
      end

      supports[brick.label] = support_bricks.map(&:label)

      iterate_coordinate_ranges(brick.x, brick.y, brick.z) do |x, y, z|
        filled_cubes[[x, y, z - z_offset]] = brick
      end
    end

    enable_part_two ? result_part_two(supports) : result_part_one(supports)
  end

  def result_part_one(supports)
    bricks.size -
      supports
      .values
      .select { |support| support.size == 1 }
      .flatten
      .delete_if { |support| support == GROUND.label }
      .uniq
      .size
  end

  def result_part_two(supports)
    fallen_bricks_counts = []

    bricks.each_with_index do |brick, index|
      fallen = [brick.label]

      bricks[index + 1..].each do |next_brick|
        fallen << next_brick.label if (supports[next_brick.label] - fallen).empty?
      end

      fallen_bricks_counts << (fallen.size - 1)
    end

    fallen_bricks_counts.sum
  end

  private

  def iterate_coordinate_ranges(x_range, y_range, z_range)
    x_range.each do |x|
      y_range.each do |y|
        z_range.each do |z|
          yield(x, y, z)
        end
      end
    end
  end

  def find_support(brick, filled_cubes, z_offset)
    support_bricks = []
    support_bricks << (GROUND) if [brick.z.begin - z_offset, brick.z.end - z_offset].any? { |z| z <= 0 }

    iterate_coordinate_ranges(brick.x, brick.y, brick.z) do |x, y, z|
      brick_from_cube = filled_cubes[[x, y, z - z_offset]]
      support_bricks << brick_from_cube unless brick_from_cube.nil?
    end

    support_bricks.uniq
  end

  def bricks
    return @bricks unless @bricks.nil?

    label = '@'

    @bricks =
      @input
      .map { |line| Brick.new(line, label = label.next) }
      .sort { |brick_a, brick_b| brick_a.z.min <=> brick_b.z.min }
  end
end
