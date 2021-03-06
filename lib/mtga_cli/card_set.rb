# An MTGA set in your collection

module MtgaCli
  class CardSet
    attr_accessor :code, :name, :cards

    def initialize(set_code, cards, collection_data)
      @code = set_code
      @name = cards.first['set_name']
      @cards = create_cards(cards, collection_data)
    end

    def count
      @cards.count * 4
    end

    def full_sets
      @cards.count { |card| card.count >= 4 }
    end

    def collected
      @cards.sum { |card| card.count }
    end

    def percentage
      return 0.0 if count == 0
      (collected.to_f / count.to_f) * 100.0
    end

    def full_set_percentage
      return 0.0 if @cards.count == 0
      (full_sets.to_f / @cards.count.to_f) * 100.0
    end

    def cards_by_rarity(rarity)
      @cards.select { |card| card.rarity == rarity }
    end

    def count_by_rarity(rarity)
      cards_by_rarity(rarity).count * 4
    end

    def full_sets_by_rarity(rarity)
      cards_by_rarity(rarity).count { |card| card.count >= 4 }
    end

    def collected_by_rarity(rarity)
      cards_by_rarity(rarity).sum { |card| card.count }
    end

    def percentage_by_rarity(rarity)
      return 0.0 if count_by_rarity(rarity) == 0
      (collected_by_rarity(rarity).to_f / count_by_rarity(rarity).to_f) * 100.0
    end

    def full_set_percentage_by_rarity(rarity)
      return 0.0 if count_by_rarity(rarity) == 0
      (full_sets_by_rarity(rarity).to_f / cards_by_rarity(rarity).count.to_f) * 100.0
    end

    private

    def create_cards(cards, collection_data)
      cards.map do |card|
        arena_id = card['arena_id']
        card_count = collection_data[arena_id] || 0
        Card.new(card, card_count)
      end
    end
  end
end
