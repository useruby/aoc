# frozen_string_literal: true

require "#{__dir__}/support"

describe Day01 do
  let(:result) { calibration_values.sum }

  describe 'part one' do
    subject { Day01.new(input) }

    let(:input) do
      %w[
        1abc2
        pqr3stu8vwx
        a1b2c3d4e5f
        treb7uchet
      ]
    end

    let(:calibration_values) { [12, 38, 15, 77] }

    it_returns_correct_result
  end

  describe 'part two' do
    subject { Day01.new(input, enable_part_two: true) }

    let(:input) do
      %w[
        two1nine
        eightwothree
        abcone2threexyz
        xtwone3four
        4nineeightseven2
        zoneight234
        7pqrstsixteen
      ]
    end

    let(:calibration_values) { [29, 83, 13, 24, 42, 14, 76] }

    it_returns_correct_result
  end
end
