# frozen_string_literal: true

require "#{__dir__}/support"

describe Day15 do
  let(:input) { ['rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7'] }

  describe 'part one' do
    subject { Day15.new(input) }

    let(:result) { 1320 }

    it_returns_correct_result

    describe 'when input is HASH' do
      let(:input) { ['HASH'] }

      let(:result) { 52 }

      it_returns_correct_result
    end
  end

  describe 'part two' do
    subject { Day15.new(input, enable_part_two: true) }

    let(:result) { 145 }

    it_returns_correct_result
  end
end
