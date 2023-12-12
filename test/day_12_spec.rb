# frozen_string_literal: true

require "#{__dir__}/support"

describe Day12 do
  let(:input) do
    [
      '???.### 1,1,3',
      '.??..??...?##. 1,1,3',
      '?#?#?#?#?#?#?#? 1,3,1,6',
      '????.#...#... 4,1,1',
      '????.######..#####. 1,6,5',
      '?###???????? 3,2,1'
    ]
  end

  describe 'part one' do
    subject { Day12.new(input) }

    let(:result) { 21 }

    it_returns_correct_result
  end

  describe 'part two' do
    subject { Day12.new(input, enable_part_two: true) }

    let(:result) { 525_152 }

    it_returns_correct_result
  end
end
