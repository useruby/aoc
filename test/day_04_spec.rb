# frozen_string_literal: true

require "#{__dir__}/support"

describe Day04 do
  let(:input) do
    [
      'Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53',
      'Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19',
      'Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1',
      'Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83',
      'Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36',
      'Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11'
    ]
  end

  describe 'part one' do
    subject { Day04.new(input) }

    let(:result) { cards_points.sum }
    let(:cards_points) { [8, 2, 2, 1] }

    it_returns_correct_result
  end

  describe 'part two' do
    subject { Day04.new(input, enable_part_two: true) }

    let(:result) { 30 }

    it_returns_correct_result
  end
end
