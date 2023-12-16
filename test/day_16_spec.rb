# frozen_string_literal: true

require "#{__dir__}/support"

describe Day16 do
  let(:input) do
    %w[
      .|...\....
      |.-.\.....
      .....|-...
      ........|.
      ..........
      .........\
      ..../.\\\\..
      .-.-/..|..
      .|....-|.\
      ..//.|....
    ]
  end

  describe 'part one' do
    subject { Day16.new(input) }

    let(:result) { 46 }

    it_returns_correct_result
  end

  describe 'part two' do
    subject { Day16.new(input, enable_part_two: true) }

    let(:result) { 51 }

    it_returns_correct_result
  end
end
