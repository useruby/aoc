# frozen_string_literal: true

class Day08 < Day
  def result
    moves, map = parse_input

    starting_nodes =
      if enable_part_two
        last_char = map.keys.first[-1]
        map.keys.select { |key| key.end_with?(last_char) }
      else
        [map.keys.first]
      end

    steps(moves, starting_nodes, map).inject(1) { |memo, item| memo.lcm(item) }
  end

  private

  def steps(moves, starting_nodes, map)
    starting_nodes.map do |current_node|
      steps = 0

      until finish?(current_node, map)
        moves.each do |move|
          steps += 1

          current_node = map[current_node][move == 'L' ? 0 : 1]

          break if finish?(current_node, map)
        end
      end

      steps
    end
  end

  def finish?(current_node, map)
    last_key = map.keys.last
    (enable_part_two ? current_node.end_with?(last_key[-1]) : current_node == last_key)
  end

  def parse_input
    moves = @input.first.chars
    map = @input.filter_map { |line| create_node(line) }.sort do |node_a, node_b|
      if enable_part_two
        node_a.first[-1] <=> node_b.first[-1]
      else
        node_a.first <=> node_b.first
      end
    end.to_h

    [moves, map]
  end

  def create_node(line)
    match = line.match(/(?<node>.*)\s=\s\((?<left>.*),\s(?<right>.*)\)/)

    return if match.nil?

    [match[:node], [match[:left], match[:right]]]
  end
end
