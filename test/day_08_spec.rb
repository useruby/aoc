# frozen_string_literal: true

require "#{__dir__}/support"

describe Day08 do
  describe 'part one' do
    subject { Day08.new(input) }

    let(:input) do
      [
        'RL',
        '',
        'DDD = (DDD, DDD)',
        'EEE = (EEE, EEE)',
        'AAA = (BBB, CCC)',
        'BBB = (DDD, EEE)',
        'CCC = (ZZZ, GGG)',
        'GGG = (GGG, GGG)',
        'ZZZ = (ZZZ, ZZZ)'
      ]
    end

    let(:result) { 2 }

    it_returns_correct_result

    describe 'when need to repeat the whole sequence' do
      let(:input) do
        [
          'LLR',
          '',
          'AAA = (BBB, BBB)',
          'BBB = (AAA, ZZZ)',
          'ZZZ = (ZZZ, ZZZ)'
        ]
      end

      let(:result) { 6 }

      it_returns_correct_result
    end
  end

  describe 'part two' do
    subject { Day08.new(input, enable_part_two: true) }

    let(:input) do
      [
        'LR',
        '',
        '11A = (11B, XXX)',
        '11B = (XXX, 11Z)',
        '11Z = (11B, XXX)',
        '22A = (22B, XXX)',
        '22B = (22C, 22C)',
        '22C = (22Z, 22Z)',
        '22Z = (22B, 22B)',
        'XXX = (XXX, XXX)'
      ]
    end

    let(:result) { 6 }

    it_returns_correct_result
  end
end
