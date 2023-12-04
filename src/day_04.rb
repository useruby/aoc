# frozen_string_literal: true

class Day04 < Day
  self.record_class =
    Class.new(Record) do
      def setup
        @winner_numbers, @card_numbers = @payload.split('|').map { |item| item.split.map(&:to_i) }
      end

      def points
        number_winner_cards.positive? ? 2**(number_winner_cards - 1) : 0
      end

      def number_winner_cards
        @number_winner_cards ||= (@winner_numbers & @card_numbers).size
      end
    end

  def cards_points
    @records.sum(&:points)
  end

  def extra_cards(cards = [], number_captured_cards = 0)
    cards = @records if number_captured_cards.zero?
    return number_captured_cards if cards.empty?

    captured_cards = []

    cards.each do |card|
      next unless card.number_winner_cards.positive?

      card.number_winner_cards.times do |index|
        next_card_index = index + card.id

        break if next_card_index >= @records.size

        number_captured_cards += 1
        captured_cards << @records[next_card_index]
      end
    end

    extra_cards(captured_cards, number_captured_cards)
  end

  def result
    if enable_part_two
      extra_cards + @records.size
    else
      cards_points
    end
  end
end
