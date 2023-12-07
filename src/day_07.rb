# frozen_string_literal: true

class Day07 < Day
  CARD_RANKS = %w[A K Q J T 9 8 7 6 5 4 3 2].reverse.freeze
  CARD_RANKS_PART_TWO = %w[A K Q T 9 8 7 6 5 4 3 2 J].reverse.freeze
  FIVE_OF_A_KIND =  70_000_000
  FOUR_OF_A_KIND =  60_000_000
  FULL_HOUSE =      50_000_000
  THREE_OF_A_KIND = 40_000_000
  TWO_PAIR =        30_000_000
  ONE_PAIR =        20_000_000
  HIGH_CARD =       10_000_000
  JOKER = 'J'

  class Hand
    attr_reader :bid, :cards

    def initialize(cards, bid, card_ranks)
      @cards = cards.chars
      @bid = bid.to_i
      @card_ranks = card_ranks
      @joker_enabled = card_ranks.first == JOKER
    end

    def rank
      cards_rank = @cards.map { |card| (@card_ranks.index(card) + 1).to_s(16) }.join.to_i(16)

      grouped_cards = group_cards_by_rank(@cards)
      enable_jokers!(grouped_cards) if @joker_enabled && grouped_cards.size > 1

      type(grouped_cards.first.size, grouped_cards.size) + cards_rank
    end

    private

    def type(biggest_group_size, number_of_groups)
      case [biggest_group_size, number_of_groups]
      in [5, Integer] then FIVE_OF_A_KIND
      in [4, Integer] then FOUR_OF_A_KIND
      in [3, 2] then FULL_HOUSE
      in [3, Integer] then THREE_OF_A_KIND
      in [2, 3] then TWO_PAIR
      in [2, Integer] then ONE_PAIR
      in [1, Integer] then HIGH_CARD
      end
    end

    def group_cards_by_rank(cards)
      cards.group_by { |item| item }.values.sort { |item_a, item_b| item_b.size <=> item_a.size }
    end

    def enable_jokers!(grouped_cards)
      jokers = grouped_cards.find { |item| item.include?(JOKER) }

      return unless jokers

      grouped_cards[grouped_cards.first.include?(JOKER) ? 1 : 0] += jokers
      grouped_cards.delete(jokers)
    end
  end

  def result
    hands
      .sort_by(&:rank)
      .each_with_index.sum { |hand, index| hand.bid * (index + 1) }
  end

  private

  def hands
    card_ranks = enable_part_two ? CARD_RANKS_PART_TWO : CARD_RANKS
    @hands ||= @input.map { |line| Hand.new(*line.split, card_ranks) }
  end
end
