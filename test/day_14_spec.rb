# frozen_string_literal: true

require "#{__dir__}/support"

describe Day14 do
  let(:input) do
    [
      'O....#....',
      'O.OO#....#',
      '.....##...',
      'OO.#O....O',
      '.O.....O#.',
      'O.#..O.#.#',
      '..O..#O..O',
      '.......O..',
      '#....###..',
      '#OO..#....'
    ]
  end

  describe 'part one' do
    subject { Day14.new(input) }

    let(:result) { 136 }

    it_returns_correct_result
  end

  describe 'part two' do
    subject { Day14.new(input, enable_part_two: true) }

    let(:result) { 64 }

    it_returns_correct_result
  end
end
