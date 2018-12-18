# Reperesents an MTGA card collection

module MtgaCli
  class Collection
    attr_reader :timestamp, :sets

    def initialize(timestamp, data)
      @timestamp = timestamp
      @data = data
      @sets = create_sets
    end

    def summary
      @sets.each do |set|
        puts "Set '#{set.name}' (#{set.code})"
        puts "Overall: #{set.collected}/#{set.count} complete: #{'%.02f' % set.percentage}"
        ['common', 'uncommon', 'rare', 'mythic'].each do |rarity|
          collected = set.collected_by_rarity(rarity)
          count = set.count_by_rarity(rarity)
          percentage = set.percentage_by_rarity(rarity)
          puts "  - #{rarity.capitalize} #{collected}/#{count} complete: #{'%.02f' % percentage}"
        end
        puts
      end
    end

  private

    def create_sets
      MtgaCli.card_db.sets.map do |set, cards|
        CardSet.new(set, cards, @data)
      end
    end
  end
end
