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
        puts "Overall: #{set.collected}/#{set.count}" +
          " cards: #{'%.02f' % set.percentage}%" +
          " full sets: #{'%.02f' % set.full_set_percentage}"
        ['common', 'uncommon', 'rare', 'mythic'].each do |rarity|
          collected = set.collected_by_rarity(rarity)
          count = set.count_by_rarity(rarity)
          percentage = set.percentage_by_rarity(rarity)
          full_set_percentage = set.full_set_percentage_by_rarity(rarity)
          puts "  - #{rarity.capitalize} #{collected}/#{count}" +
            " cards: #{'%.02f' % percentage}%" +
            " full sets: #{'%.02f' % full_set_percentage}%"
        end
        puts
      end
    end

    def show(selected_set = nil, type = nil)
      @sets.each do |set|
        next if ( selected_set && ( set.code != selected_set ) )
        puts "Set '#{set.name}' (#{set.code})"
        ['common', 'uncommon', 'rare', 'mythic'].each do |rarity|
          puts "- #{rarity.capitalize}:"
          set.cards_by_rarity(rarity).sort_by{|card| card.count}.reverse.each do |card|
            next if type and not card.type.include?(type)
            puts "  - #{card.count}/4 #{card.name} (#{card.rarity})"
          end
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
      diff_data = {}
      @data.each do |id, count|
        diff_count = count - (other_collection.data[id] || 0)
        diff_data[id] = diff_count if diff_count > 0
      end
      diff_stamp = "#{other_collection.timestamp} => #{@timestamp}"
      Collection.new(diff_stamp, diff_data)
    end

  private

    def create_sets
      MtgaCli.card_db.sets.map do |set, cards|
        CardSet.new(set, cards, @data)
      end
    end
  end
end
