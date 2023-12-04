# frozen_string_literal: true

class Day03 < Day
  def numbers_adjacent_to_symbol
    selected_numbers = []

    input.each_with_index do |line, index|
      offset = 0

      loop do
        match = line.match(/\d+/, offset)
        break if match.nil?

        offset = match.end(0) + 1

        selected_numbers << match[0].to_i if number_adjacent_to_symbol?([match.begin(0), match.end(0)], index)
      end
    end

    selected_numbers
  end

  def gear_ratios
    gear_ratios = []

    input.each_with_index do |line, index|
      offset = 0

      loop do
        offset = line.index('*', offset)
        break if offset.nil?

        gear_ratios << gear_ratio(offset, index)

        offset += 1
      end
    end

    gear_ratios.compact
  end

  def result
    if enable_part_two
      gear_ratios
    else
      numbers_adjacent_to_symbol
    end.sum
  end

  private

  def number_adjacent_to_symbol?(begin_end, line_index)
    begin_number_position, end_number_position = begin_end
    number_position = (begin_number_position - 1..end_number_position)

    surround_lines(line_index).each do |line|
      non_digit_positions = []
      offset = 0
      loop do
        offset = line.index(/[^\d|.]/, offset)

        break if offset.nil?

        non_digit_positions << offset
        offset += 1
      end

      return true if non_digit_positions.any? { |position| number_position.include?(position) }
    end

    false
  end

  def gear_ratio(star_position, line_index)
    ratios = []
    surround_lines(line_index).each_with_index do |line, _index|
      offset = 0
      loop do
        match = line.match(/\d+/, offset)

        break if match.nil?

        if (match.begin(0) - 1..match.end(0)).include?(star_position)
          distance = [(star_position - match.begin(0)).abs, (star_position - match.end(0)).abs].min
          ratios << [match[0].to_i, distance]
        end

        offset = match.end(0) + 1
      end
    end

    ratios = ratios.sort { |(_, distance_a), (_, distance_b)| distance_a <=> distance_b }[0..2]
    ratios.size == 2 ? ratios[0][0] * ratios[1][0] : nil
  end

  def surround_lines(line_index)
    [
      input[line_index], # current line
      (input[line_index - 1] unless line_index.zero?), # previous line
      (input[line_index + 1] unless line_index >= input.size) # next line
    ].compact.each
  end
end
