# frozen_string_literal: true

class Day
  class << self
    attr_accessor :record_class
  end

  attr_reader :input, :enable_part_two

  def initialize(input, enable_part_two: false)
    @input = input
    @enable_part_two = enable_part_two

    record_class = self.class.record_class
    @records = input.map { |line| record_class.create(line) } unless record_class.nil?
  end

  def result
    nil
  end
end
