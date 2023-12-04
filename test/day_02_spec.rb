# frozen_string_literal: true

require "#{__dir__}/support"

describe Day02 do
  let(:input) do
    [
      'Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green',
      'Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue',
      'Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red',
      'Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red',
      'Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green'
    ]
  end

  describe 'part one' do
    subject { Day02.new(input) }

    let(:result) { possible_games_ids.sum }
    let(:possible_games_ids) { [1, 2, 5] }

    it_returns_correct_result
  end

  describe 'part two' do
    subject { Day02.new(input, enable_part_two: true) }

    let(:result) { games_powers.sum }
    let(:games_powers) { [48, 12, 1560, 630, 36] }

    it_returns_correct_result
  end
end
