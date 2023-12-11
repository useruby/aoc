# frozen_string_literal: true

class Day11 < Day
  attr_writer :multiplier

  def result
    multiplier = enable_part_two ? (@multiplier || 1_000_000) - 1 : 1

    offset = empty_space
    galaxies = galaxies(offset, multiplier)
    calculate_distances(galaxies)
  end

  private

  def calculate_distances(galaxies)
    galaxies.size.times.sum do |galaxy_a_index|
      pairs = (galaxies.size - galaxy_a_index - 1)

      Array.new(pairs) { |index| index + galaxy_a_index + 1 }.sum do |galaxy_b_index|
        distance_between_galaxies(galaxies[galaxy_a_index], galaxies[galaxy_b_index])
      end
    end
  end

  def distance_between_galaxies(galaxy_a, galaxy_b)
    galaxy_a_x, galaxy_a_y = galaxy_a
    galaxy_b_x, galaxy_b_y = galaxy_b

    (galaxy_a_x - galaxy_b_x).abs + (galaxy_a_y - galaxy_b_y).abs
  end

  def empty_space
    rows = []
    columns = []

    @input.each_with_index do |line, index|
      rows << index if line.chars.all?('.')
    end

    @input.first.size.times do |index|
      columns << index if @input.all? { |line| line[index] == '.' }
    end

    [columns, rows]
  end

  def galaxies(offset, multiplier = 1)
    rows_offset, columns_offset = offset
    galaxies = []

    @input.each_with_index do |line, y|
      line.chars.each_with_index do |char, x|
        next unless char == '#'

        galaxy_x = (rows_offset.count { |item| item < x } * multiplier) + x
        galaxy_y = (columns_offset.count { |item| item < y } * multiplier) + y
        galaxies << [galaxy_x, galaxy_y]
      end
    end

    galaxies
  end
end
