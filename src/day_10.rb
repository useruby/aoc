# frozen_string_literal: true

class Day10 < Day
  PIPES = {
    'NS' => '|',
    'EW' => '-',
    'NE' => 'L',
    'NW' => 'J',
    'SW' => '7',
    'SE' => 'F'
  }.freeze

  NS_PIPES = %w[| L7 FJ].freeze

  directions = [%w[N S], %w[E W]]
  OPPOSITE_DIRECTION = (directions + directions.map(&:reverse)).to_h.freeze
  DIRECTIONS = directions.flatten.freeze

  def result
    path = path(pipes_map)

    return path.size / 2 unless enable_part_two

    start_x, start_y = @start
    pipes_map[start_y][start_x] = start_pipe(path)

    cleanup(pipes_map, path)

    intersections.sum { |intersect| intersect.even? ? 0 : 1 }
  end

  private

  def start_pipe(path)
    path_second_x, path_second_y = path[1]
    path_last_x, path_last_y = path[-2]

    return '|' if path_last_x == path_second_x
    return '-' if path_last_y == path_second_y

    PIPES[
      (path_last_y > path_second_y ? 'N' : OPPOSITE_DIRECTION['N']) +
      (path_last_x > path_second_x ? 'E' : OPPOSITE_DIRECTION['E'])
    ]
  end

  def cleanup(pipes_map, path)
    pipes_map.each_with_index.map do |line, y|
      path_indexes = path.select { |_, path_y| path_y == y }.map(&:first)
      (line.size.times.to_a - path_indexes).each { |index| line[index] = '.' }
    end
  end

  def intersections
    pipes_map.sum([]) do |line|
      line.map.with_index { |pipe, index| count_crossing(line[index..]) if pipe == '.' }.compact
    end
  end

  def count_crossing(line)
    line_without_east_west_pipe = line.join.delete('-')
    NS_PIPES.sum { |pipe| line_without_east_west_pipe.scan(pipe).size }
  end

  def path(pipes_map)
    DIRECTIONS.each do |direction|
      path = [(x, y = @start)]

      loop do
        case direction
        when 'N' then y -= 1
        when 'S' then y += 1
        when 'E' then x += 1
        when 'W' then x -= 1
        end

        path << [x, y]
        return path if pipes_map[y][x] == 'S'

        direction = move(pipes_map[y][x], direction)
        break if direction.nil?
      end
    end
  end

  def move(char, direction)
    directions, = PIPES.rassoc(char)

    return if directions.nil?

    next_direction = directions.chars - [OPPOSITE_DIRECTION[direction]]

    next_direction.first if next_direction.size == 1
  end

  def pipes_map
    @pipes_map ||=
      @input.map.with_index do |line, y|
        line.chars.map.with_index do |char, x|
          @start = [x, y] if char == 'S'
          char
        end
      end
  end
end
