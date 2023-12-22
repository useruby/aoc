# frozen_string_literal: true

require "#{__dir__}/support"

describe Day21 do
  subject { Day21.new(input, steps) }

  let(:input) do
    [
      '...........',
      '.....###.#.',
      '.###.##..#.',
      '..#.#...#..',
      '....#.#....',
      '.##..S####.',
      '.##..#...#.',
      '.......##..',
      '.##.#.####.',
      '.##..##.##.',
      '...........'
    ]
  end

  describe 'part one' do
    let(:steps) { 6 }
    let(:result) { 16 }

    it_returns_correct_result
  end

  describe 'part two' do
    # [[10, 50], [50, 1594], [100, 6536], [500, 167004], [1000, 668697], [5000, 16733044]].each do |steps, result|
    [[10, 50], [50, 1594], [100, 6536]].each do |steps, result|
      describe 'when n steps' do
        let(:steps) { steps }
        let(:result) { result }

        it_returns_correct_result
      end
    end
  end
end
