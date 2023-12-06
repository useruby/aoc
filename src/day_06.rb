# frozen_string_literal: true

class Day06 < Day
  def result
    number_of_ways_to_win.inject(1) { |sum, win_count| sum * win_count }
  end

  private

  def number_of_ways_to_win
    load_game_stat.map do |time, distance|
      index = 0
      number_of_win = 0

      while index < time
        index += 1
        calculated_distance = (time - index) * index
        number_of_win += 1 if calculated_distance > distance
      end

      number_of_win
    end
  end

  def load_game_stat
    times, distances =
      @input
      .map { |item| item.split(':').last }
      .map { |item| enable_part_two ? [item.delete("\s").to_i] : item.split.map(&:to_i) }

    times.each_with_index.map { |time, index| [time, distances[index]] }
  end
end
