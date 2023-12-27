# frozen_string_literal: true

require "#{__dir__}/support"

describe Day24 do
  let(:input) do
    [
      '19, 13, 30 @ -2,  1, -2',
      '18, 19, 22 @ -1, -1, -2',
      '20, 25, 34 @ -2, -2, -4',
      '12, 31, 28 @ -1, -2, -1',
      '20, 19, 15 @  1, -5, -3'
    ]
  end

  describe 'part one' do
    subject { Day24.new(input, (7..27)) }

    let(:result) { 2 }

    it_returns_correct_result
  end

  describe 'part two' do
    subject { Day24.new(input, enable_part_two: true) }

    let(:result) { 47 }

    # it_returns_correct_result
  end
end
