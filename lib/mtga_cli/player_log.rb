# class to parse the MTGA output log

module MtgaCli
  class PlayerLog
    def initialize(log_file)
      @log_file = log_file
    end

    def collection
      @collection ||= latest('GetPlayerCardsV3')
    end

    def inventory
      @inventory ||= latest('GetPlayerInventory')
    end

  private

    def latest(method)
      JSON.parse(scan(method).last.first)['payload']
    end

    def scan(method)
      log.scan(/<== PlayerInventory\.#{method} ([^\r\n]+)/m)
    end

    def log
      @log ||= File.read(@log_file)
    end
  end
end
