# frozen_string_literal: true

require "#{__dir__}/support"

describe Day06 do
  let(:input) do
    [
      'Time:      7  15   30',
      'Distance:  9  40  200'
    ]
  end

  describe 'part one' do
    subject { Day06.new(input) }

    let(:result) { number_of_ways_to_win.inject(1) { |sum, win| sum * win } }
    let(:number_of_ways_to_win) { [4, 8, 9] }

    it_returns_correct_result
  end

  describe 'part two' do
    subject { Day06.new(input, enable_part_two: true) }

    let(:result) { 71_503 }

    it_returns_correct_result
  end
end
