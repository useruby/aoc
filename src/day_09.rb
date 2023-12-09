# frozen_string_literal: true

class Day09 < Day
  def result
    report.sum { |line| next_value(line) }
  end

  private

  def report
    @input.map { |line| line.split.map(&:to_i) }
  end

  def next_value(values)
    sequences = [values]

    loop do
      sequence = sequences.last.each_cons(2).map { |value_one, value_two| value_two - value_one }
      break if sequence.all?(&:zero?)

      sequences << sequence
    end

    sequences.reverse.inject(0) do |last_value, sequence|
      enable_part_two ? sequence.first - last_value : sequence.last + last_value
    end
  end
end
