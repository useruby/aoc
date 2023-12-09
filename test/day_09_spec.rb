# frozen_string_literal: true

require "#{__dir__}/support"

describe Day09 do
  let(:input) do
    [
      '0 3 6 9 12 15',
      '1 3 6 10 15 21',
      '10 13 16 21 30 45'
    ]
  end

  describe 'part one' do
    subject { Day09.new(input) }

    let(:result) { 114 }

    it_returns_correct_result
  end

  describe 'part two' do
    subject { Day09.new(input, enable_part_two: true) }

    let(:result) { 2 }

    it_returns_correct_result
  end
end
