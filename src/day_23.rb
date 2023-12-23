# frozen_string_literal: true

class Day23 < Day
  DIRECTIONS = [[0, 1], [0, -1], [1, 0], [-1, 0]].freeze
  SLOPES = {
    [0, 1] => '>',
    [0, -1] => '<',
    [-1, 0] => '^',
    [1, 0] => 'v'
  }.freeze
  SLOPES_SIGNS = SLOPES.values.freeze
  START = [0, 1].freeze

  def result
    load_maze

    if enable_part_two
      nodes = find_nodes
      @end = [@maze.size - 1, @maze[-1].index('.')]
      nodes.push(START, @end)
      graph = build_graph(nodes)

      cache = Set[]
      dfs(graph, START, cache)
    else
      pathes = [[START]]
      solved_pathes = []

      until pathes.empty?
        pathes = pathes.flat_map { |path| walk(path) }

        pathes.delete_if do |path|
          solved_path = (path.last[0] == (@maze.size - 1))
          solved_pathes << path if solved_path
          solved_path
        end
      end

      solved_pathes.max_by(&:size).size - 1
    end
  end

  private

  def load_maze
    @maze = @input.map(&:chars)
  end

  def find_nodes
    @maze.map.with_index do |line, row|
      line.map.with_index do |_tile, col|
        next if @maze[row][col] == '#'

        possible_moves = DIRECTIONS.count do |direction_row, direction_col|
          position = [row + direction_row, col + direction_col]
          can_walk?(*position, [direction_row, direction_col], nil)
        end

        [row, col] if possible_moves >= 3
      end.compact
    end.flatten(1)
  end

  def build_graph(nodes)
    graph = nodes.to_h { |node| [node, {}] }

    nodes.each do |node|
      stack = [[0, *node]]
      seen = [node]

      until stack.empty?
        steps, row, col = stack.pop

        if !steps.zero? && nodes.include?([row, col])
          graph[node][[row, col]] = steps
          next
        end

        DIRECTIONS.filter_map do |direction_row, direction_col|
          position = [row + direction_row, col + direction_col]
          if can_walk?(*position, [direction_row, direction_col], nil)
            next if seen.include?(position)

            stack.push([steps + 1, *position])
            seen << position
          end
        end
      end
    end

    graph
  end

  def dfs(graph, node, cache)
    return 0 if node == @end

    distance = -Float::INFINITY

    cache.add(node)

    graph[node].each do |connected_node, node_distance|
      next if cache.include?(connected_node)

      distance = [distance, dfs(graph, connected_node, cache) + node_distance].max
    end

    cache.delete(node)

    distance
  end

  def walk(path)
    row, col = path.last

    next_steps = DIRECTIONS.filter_map do |direction_row, direction_col|
      position = [row + direction_row, col + direction_col]
      position if can_walk?(*position, [direction_row, direction_col], path)
    end

    next_steps.map { |next_step| Array.new(path).push(next_step) }
  end

  def can_walk?(row, col, direction, path)
    return false if row.negative? || col.negative? || row >= @maze.size || col >= @maze.first.size
    return false if path&.include?([row, col])

    return true if  @maze[row][col] == '.'
    return true if enable_part_two && SLOPES_SIGNS.include?(@maze[row][col])
    return true if SLOPES_SIGNS.include?(@maze[row][col]) && SLOPES[direction] == @maze[row][col]

    false
  end
end
