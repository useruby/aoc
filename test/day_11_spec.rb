# frozen_string_literal: true

require "#{__dir__}/support"

describe Day11 do
  let(:input) do
    [
      '...#......',
      '.......#..',
      '#.........',
      '..........',
      '......#...',
      '.#........',
      '.........#',
      '..........',
      '.......#..',
      '#...#.....'
    ]
  end

  describe 'part one' do
    subject { Day11.new(input) }

    let(:result) { 374 }

    it_returns_correct_result
  end

  describe 'part two' do
    subject { Day11.new(input, enable_part_two: true) }

    let(:result) { 1030 }
    let(:multiplier) { 10 }

    before { subject.multiplier = multiplier }

    it_returns_correct_result

    describe 'when multiplier is 100' do
      let(:result) { 8410 }
      let(:multiplier) { 100 }

      it_returns_correct_result
    end
  end
end
