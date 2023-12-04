# frozen_string_literal: true

class Day02 < Day
  self.record_class =
    Class.new(Record) do
      attr_accessor :red, :green, :blue

      MAX_RED, MAX_GREEN, MAX_BLUE = [12, 13, 14].freeze

      def setup
        @red = @green = @blue = 0

        @payload.split(';').each do |item|
          item.split(',').each do |cube_stat|
            cube_count, cube_color = cube_stat.strip.split
            send("#{cube_color}=", cube_count.to_i) if send(cube_color.to_s) < cube_count.to_i
          end
        end
      end

      def valid?
        @red <= MAX_RED && @green <= MAX_GREEN && @blue <= MAX_BLUE
      end

      def power
        @red * @green * @blue
      end
    end

  def possible_games
    @records.select(&:valid?)
  end

  def result
    if enable_part_two
      @records.map(&:power).sum
    else
      possible_games.map(&:id).sum
    end
  end
end
