# MTGA card collection store
require 'mtga_cli/output_log'
require 'yaml/store'

module MtgaCli
  class CollectionStore < YAML::Store

    def initialize
      FileUtils.mkdir_p(MtgaCli.data_dir)
      db_file = File.join(MtgaCli.data_dir, 'collection_db.yaml')
      super(db_file)
    end

    def new_entry(output_log_file)
      output_log = OutputLog.new(output_log_file)
      timestamp = Time.now

      conv_collection = Hash[output_log.collection.map{|k,v| [k.to_i, v]}]

      transaction do
        self[:collection] ||= {}
        self[:collection][timestamp] = conv_collection
        self[:last] = timestamp
      end
    end

    def last_timestamp
      transaction do
        self[:last]
      end
    end

    def collection(timestamp = nil)
      timestamp ||= last_timestamp
      transaction do
        Collection.new(timestamp, self[:collection][timestamp])
      end
    end

    def timestamps
      transaction do
        self[:collection].keys.sort.reverse
      end
    end

    def history(n)
      timestamps.take(n).each_cons(2) do |new, old|
        diff_coll = collection(new) - collection(old)
        diff_coll.diff_cards
      end
    end
  end
end
