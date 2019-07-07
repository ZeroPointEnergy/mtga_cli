#
# Card Database
#
require 'yaml/store'
require 'fileutils'
require 'json'

module MtgaCli
  class Db < YAML::Store
    MTGA_SETS = ['xln', 'rix', 'dom', 'm19', 'grn', 'rna', 'war', 'm20']
    EXCLUDE_CARDS = ['Forest', 'Mountain', 'Swamp', 'Island', 'Plains']

    def initialize
      FileUtils.mkdir_p(MtgaCli.data_dir)
      db_file = File.join(MtgaCli.data_dir, 'card_db.yaml')
      super(db_file)
    end

    def import(json_file)
      import_data = JSON.parse(File.read(json_file))
      sets = {}
      import_data.each do |card|
        set = card['set']
        name = card['name']
        next unless card['arena_id']
        next unless MTGA_SETS.include?(set)
        next if EXCLUDE_CARDS.include?(name)

        sets[set] ||= []
        sets[set] << card
      end

      transaction do
        self[:sets] = sets
      end
    end

    def sets
      @sets ||= transaction(true) do
        self[:sets]
      end
    end
  end
end
