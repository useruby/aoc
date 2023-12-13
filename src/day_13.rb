# frozen_string_literal: true

class Day13 < Day
  def result
    @errors_tolerance = enable_part_two ? 1 : 0

    load_patterns.sum { |pattern| reflection_score(pattern) }
  end

  private

  def reflection_score(pattern)
    reflection_line_index = reflection_horizontal(pattern)
    return 100 * reflection_line_index unless reflection_line_index.nil?

    reflection_vertical(pattern)
  end

  def reflection_horizontal(pattern)
    (1...pattern.size).each do |line_index|
      return line_index if acceptable_reflection_error?(pattern, line_index)
    end

    nil
  end

  def acceptable_reflection_error?(pattern, line_index)
    reflection_length = [line_index, pattern.size - line_index].min

    errors =
      ((line_index - reflection_length)...line_index).inject(0) do |error_count, reflection_line_a_index|
        reflection_line_b_index = line_index + (line_index - reflection_line_a_index - 1)
        error_count += errors(pattern[reflection_line_a_index], pattern[reflection_line_b_index])

        return false if error_count > @errors_tolerance

        error_count
      end

    errors == @errors_tolerance
  end

  def reflection_vertical(pattern)
    reflection_horizontal(turn_pattern(pattern))
  end

  def errors(line_a, line_b)
    line_a.chars.zip(line_b.chars).sum { |char_a, char_b| char_a == char_b ? 0 : 1 }
  end

  # turn pattern clockwise for 90 degree
  def turn_pattern(pattern)
    turned_pattern = Array.new(pattern.first.size) { +'' }

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
