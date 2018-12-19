# Reperesents an MTGA card collection

module MtgaCli
  class Collection
    attr_reader :timestamp, :sets, :data

    def initialize(timestamp, data)
      @timestamp = timestamp
      @data = data
      @sets = create_sets
    end

    def summary
      @sets.each do |set|
        puts "Set '#{set.name}' (#{set.code})"
        puts "Overall: #{set.collected}/#{set.count} complete: #{'%.02f' % set.percentage}%"
        ['common', 'uncommon', 'rare', 'mythic'].each do |rarity|
          collected = set.collected_by_rarity(rarity)
          count = set.count_by_rarity(rarity)
          percentage = set.percentage_by_rarity(rarity)
          puts "  - #{rarity.capitalize} #{collected}/#{count} complete: #{'%.02f' % percentage}%"
        end
        puts
      end
    end

    def diff_cards
      puts @timestamp
      @sets.each do |set|
        next if set.collected == 0
        puts "  Set '#{set.name}' (#{set.code})"
        set.cards.each do |card|
          next if card.count == 0
          puts "    +#{card.count} #{card.name} (#{card.rarity})"
        end
      end
    end

    def -(other_collection)
      result = {}
      @data.each do |id, count|
        diff_count = count - (other_collection.data[id] || 0)
        result[id] = diff_count if diff_count > 0
      end
      diff_stamp = "#{other_collection.timestamp} => #{@timestamp}"
      Collection.new(diff_stamp, result)
    end

  private

    def create_sets
      MtgaCli.card_db.sets.map do |set, cards|
        CardSet.new(set, cards, @data)
      end
    end
  end
end
