# frozen_string_literal: true

require "#{__dir__}/support"

describe Day20 do
  let(:input) do
    [
      'broadcaster -> a, b, c',
      '%a -> b',
      '%b -> c',
      '%c -> inv',
      '&inv -> a'
    ]
  end

  describe 'part one' do
    subject { Day20.new(input) }

    let(:result) { 32_000_000 }

    it_returns_correct_result

    describe 'another example' do
      let(:input) do
        [
          'broadcaster -> a',
          '%a -> inv, con',
          '&inv -> b',
          '%b -> con',
          '&con -> output'
        ]
      end

      let(:result) { 11_687_500 }

      it_returns_correct_result
    end
  end

  describe 'part two' do
    subject { Day20.new(input, enable_part_two: true) }

    let(:input) do
      [
        'broadcaster -> a',
        '%a -> inv, con',
        '&inv -> b',
        '%b -> con',
        '&con -> rx'
      ]
    end

    let(:result) { 1 }

    it_returns_correct_result
  end
end
