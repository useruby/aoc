# frozen_string_literal: true

require "#{__dir__}/support"

describe Day17 do
  let(:input) do
    %w[
      2413432311323
      3215453535623
      3255245654254
      3446585845452
      4546657867536
      1438598798454
      4457876987766
      3637877979653
      4654967986887
      4564679986453
      1224686865563
      2546548887735
      4322674655533
    ]
  end

  describe 'part one' do
    subject { Day17.new(input) }

    let(:result) { 102 }

    it_returns_correct_result
  end

  describe 'part two' do
    subject { Day17.new(input, enable_part_two: true) }

    let(:result) { 94 }

    it_returns_correct_result

    describe 'another example' do
      let(:input) do
        %w[
          111111111111
          999999999991
          999999999991
          999999999991
          999999999991
        ]
      end

      let(:result) { 71 }

      it_returns_correct_result
    end
  end
end
