# frozen_string_literal: true

require "#{__dir__}/support"

describe Day22 do
  let(:input) do
    [
      '1,0,1~1,2,1',
      '0,0,2~2,0,2',
      '0,2,3~2,2,3',
      '0,0,4~0,2,4',
      '2,0,5~2,2,5',
      '0,1,6~2,1,6',
      '1,1,8~1,1,9'
    ]
  end

  describe 'part one' do
    subject { Day22.new(input) }

    let(:result) { 5 }

    it_returns_correct_result
  end

  describe 'part two' do
    subject { Day22.new(input, enable_part_two: true) }

    let(:result) { 7 }

    it_returns_correct_result
  end
end
