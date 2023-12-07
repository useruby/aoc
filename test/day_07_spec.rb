# frozen_string_literal: true

require "#{__dir__}/support"

describe Day07 do
  let(:input) do
    [
      '32T3K 765',
      'T55J5 684',
      'KK677 28',
      'KTJJT 220',
      'QQQJA 483'
    ]
  end

  describe 'part one' do
    subject { Day07.new(input) }

    let(:result) { 6440 }

    it_returns_correct_result
  end

  describe 'part two' do
    subject { Day07.new(input, enable_part_two: true) }

    let(:result) { 5905 }

    it_returns_correct_result
  end
end
