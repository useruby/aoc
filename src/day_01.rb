# frozen_string_literal: true

class Day01 < Day
  DIGITS = %w[one two three four five six seven eight nine].freeze

  def calibration_values
    if enable_part_two
      input.map { |line| replace_digits(line) }
    else
      input
    end.map { |line| text_to_number(line) }
  end

  def result
    calibration_values.sum
  end

  private

  def text_to_number(text)
    digits = text.gsub(/[^0-9]/, '').chars
    "#{digits[0]}#{digits[-1]}".to_i
  end

  def replace_digits(line)
    String.new(line).tap do |text|
      line.size.times do |offset|
        digit = DIGITS.find { |item| text.index(item, offset) == offset }

        next if digit.nil?

        text[offset] = (DIGITS.index(digit) + 1).to_s
      end
    end
  end
end
