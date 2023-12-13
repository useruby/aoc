# frozen_string_literal: true

class Day13 < Day
  def result
    load_patterns.sum { |pattern| reflection_score(pattern) }
  end

  private

  def reflection_score(pattern)
    horizontal_length, horizontal_index = reflection_horizontal(pattern)
    vertical_length, vertical_index = reflection_vertical(pattern)

    result = if horizontal_length >= vertical_length
      horizontal_index  * 100
    else
      vertical_index
    end

    # puts("result: #{result} horizontal: #{horizontal_length} vertical_length: #{vertical_length}")
    # pattern.each { |line| puts(line) }
    # puts('')

    # result
  end

  def reflection_horizontal(pattern)
    previous_line = ''

    reflection_lines = []
    pattern.each_with_index do |line, index|
      reflection_lines << index if previous_line == line

      previous_line = line
    end

    return 0 if reflection_lines.empty?

    reflection_lengths = reflection_lines.map do |reflection_line|
      pattern.size.times do |index|
        next_line_index = reflection_line + index
        previous_line_index = reflection_line - 1 - index

        next index if next_line_index >= pattern.size || previous_line_index < 0
        break index if next_line_index >= pattern.size && previous_line_index < 0
        break index if pattern[previous_line_index] != pattern[next_line_index]
      end
    end

    max_reflection_length = reflection_lengths.max

    [max_reflection_length, reflection_lines[reflection_lengths.index(max_reflection_length)]]
  end

  def reflection_vertical(pattern)
    reflection_horizontal(turn_pattern(pattern))
  end

  # turn pattern clockwise for 90 degree
  def turn_pattern(pattern)
    turned_pattern = Array.new(pattern.first.size) { String.new() }

    pattern.reverse.each_with_index do |line, char_index|
      line.chars.each_with_index do |char, line_index|
        turned_pattern[line_index][char_index] = char
      end
    end

    turned_pattern
  end

  def load_patterns
    patterns = []
    pattern = []

    @input.each do |line|
      next if line.empty? && pattern.empty?

      if line.empty?
        patterns << pattern
        pattern = []
      else
        pattern << line
      end
    end

    patterns << pattern unless pattern.empty?
    patterns
  end
end
