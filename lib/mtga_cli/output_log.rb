# class to parse the MTGA output log

module MtgaCli
  class OutputLog
    def initialize(log_file)
      @log_file = log_file
    end

    def collection
      @collection ||= JSON.parse(collection_scan.last.first)
    end

    def inventory
      @inventory ||= JSON.parse(inventory_scan.last.first)
    end

  private

    def collection_scan
      log.scan(/<== PlayerInventory\.GetPlayerCardsV3\(\d+\)\r\n({.*?^})/m)
    end

    def inventory_scan
      log.scan(/<== PlayerInventory\.GetPlayerInventory\(\d+\)\r\n({.*?^})/m)
    end

    def log
      @log ||= File.read(@log_file)
    end
  end
end
