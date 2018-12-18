# Reperesents an MTGA card collection

module MtgaCli
  class Collection
    def initialize(timestamp, data)
      @timestamp = timestamp
      @data = data
    end

    def [](value)
      @data[value]
    end
  end
end
