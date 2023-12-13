# frozen_string_literal: true

require "#{__dir__}/support"

describe Day13 do
  let(:input) do
    [
      '#.##..##.',
      '..#.##.#.',
      '##......#',
      '##......#',
      '..#.##.#.',
      '..##..##.',
      '#.#.##.#.',
      '',
      '#...##..#',
      '#....#..#',
      '..##..###',
      '#####.##.',
      '#####.##.',
      '..##..###',
      '#....#..#'
    ]
  end

  describe 'part one' do
    subject { Day13.new(input) }

    let(:result) { 405 }

    it_returns_correct_result

    describe 'two reflection points' do
      let(:input) do
        [
          '###......####',
          '..##....##...',
          '.#.######.#..',
          '#.###..###.##',
          '#.##.....#.##',
          '.#.##..##.#..',
          '.##......##..'
        ]
      end

      let(:result) { 12 }

      it_returns_correct_result
    end

    describe 'double result' do
      let(:input) do
        [
          '.#..##.#..#..',
          '#..#.####.##.',
          '###.#.##.#.##',
          '###.#.##.#.##',
          '#..#.####.##.',
          '.#..##.#..#..',
          '.#...#.#.###.',
          '##...##..##.#',
          '.#...#.....##',
          '.###..#..##.#',
          '.###..#..##.#',
          '.#...#.....##',
          '##...##..##.#',
          '.#...#.#.###.',
          '.#..##.#..#..',
          '#..#.####.##.',
          '###.#.##...##'
        ]
      end

      let(:result) { 300 }

      it_returns_correct_result
    end
  end

  describe 'part two' do
    subject { Day13.new(input, enable_part_two: true) }

    let(:result) { 400 }

    it_returns_correct_result
  end
end
