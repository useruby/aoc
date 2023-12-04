# frozen_string_literal: true

require "#{__dir__}/support"

describe Day03 do
  let(:input) do
    %w[
      467..114..
      ...*......
      ..35..633.
      ......#...
      617*......
      .....+.58.
      ..592.....
      ......755.
      ...$.*....
      .664.598..
    ]
  end

  describe 'part one' do
    subject { Day03.new(input) }

    let(:result) { numbers_adjacent_to_symbol.sum }
    let(:numbers_adjacent_to_symbol) { [467, 35, 633, 617, 592, 755, 664, 598] }

    it_returns_correct_result
  end

  describe 'part two' do
    subject { Day03.new(input, enable_part_two: true) }

    let(:result) { gear_ratios.sum }
    let(:gear_ratios) { [16_345, 451_490] }

    it_returns_correct_result
  end
end
