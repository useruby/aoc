# frozen_string_literal: true

require "#{__dir__}/support"

describe Day25 do
  let(:input) do
    [
      'jqt: rhn xhk nvd',
      'rsh: frs pzl lsr',
      'xhk: hfx',
      'cmg: qnr nvd lhk bvb',
      'rhn: xhk bvb hfx',
      'bvb: xhk hfx',
      'pzl: lsr hfx nvd',
      'qnr: nvd',
      'ntq: jqt hfx bvb xhk',
      'nvd: lhk',
      'lsr: lhk',
      'rzs: qnr cmg lsr rsh',
      'frs: qnr lhk lsr'
    ]
  end

  describe 'part one' do
    subject { Day25.new(input) }

    let(:result) { 54 }

    it_returns_correct_result
  end

  describe 'part two' do
    subject { Day25.new(input, enable_part_two: true) }

    let(:result) { 2 }

    # it_returns_correct_result
  end
end
