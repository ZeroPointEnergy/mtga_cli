# A card in your MTGA Collection

module MtgaCli
  class Card
    attr_reader :count

    def initialize(data, count)
      @count = count
      @data = data
    end

    def name
      @data['name']
    end

    def complete?
      @count >= 4
    end

    def incomplete?
      !complete?
    end

    def missing?
      @count == 0
    end

    def rarity
      @data['rarity']
    end

    def type
      @data['type_line']
    end
  end
end
