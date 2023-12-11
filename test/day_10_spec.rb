# frozen_string_literal: true

require "#{__dir__}/support"

describe Day10 do
  describe 'part one' do
    subject { Day10.new(input) }
    let(:input) do
      %w[
        .....
        .S-7.
        .|.|.
        .L-J.
        .....
      ]
    end

    let(:result) { 4 }

    it_returns_correct_result

    describe 'complex loop' do
      let(:input) do
        %w[
          ..F7.
          .FJ|.
          SJ.L7
          |F--J
          LJ...
        ]
      end

      let(:result) { 8 }

      it_returns_correct_result
    end
  end

  describe 'part two' do
    subject { Day10.new(input, enable_part_two: true) }

    let(:input) do
      %w[
        ...........
        .S-------7.
        .|F-----7|.
        .||.....||.
        .||.....||.
        .|L-7.F-J|.
        .|..|.|..|.
        .L--J.L--J.
        ...........
      ]
    end

    let(:result) { 4 }

    it_returns_correct_result

    describe 'when no gap' do
      let(:input) do
        %w[
          ..........
          .S------7.
          .|F----7|.
          .||....||.
          .||....||.
          .|L-7F-J|.
          .|..||..|.
          .L--JL--J.
          ..........
        ]
      end

      let(:result) { 4 }

      it_returns_correct_result
    end

    describe 'larger example' do
      let(:input) do
        %w[
          .F----7F7F7F7F-7....
          .|F--7||||||||FJ....
          .||.FJ||||||||L7....
          FJL7L7LJLJ||LJ.L-7..
          L--J.L7...LJS7F-7L7.
          ....F-J..F7FJ|L7L7L7
          ....L7.F7||L7|.L7L7|
          .....|FJLJ|FJ|F7|.LJ
          ....FJL-7.||.||||...
          ....L---J.LJ.LJLJ...
        ]
      end

      let(:result) { 8 }

      it_returns_correct_result
    end

    describe 'when map contains noise' do
      let(:input) do
        %w[
          FF7FSF7F7F7F7F7F---7
          L|LJ||||||||||||F--J
          FL-7LJLJ||||||LJL-77
          F--JF--7||LJLJ7F7FJ-
          L---JF-JLJ.||-FJLJJ7
          |F|F-JF---7F7-L7L|7|
          |FFJF7L7F-JF7|JL---7
          7-L-JL7||F7|L7F-7F7|
          L.L7LFJ|||||FJL7||LJ
          L7JLJL-JLJLJL--JLJ.L
        ]
      end

      let(:result) { 10 }

      it_returns_correct_result
    end
  end
end
