#
# Card Database
#
require 'yaml/store'
require 'fileutils'
require 'json'

module MtgaCli
  class Db < YAML::Store
    MTGA_SETS = ['xln', 'rix', 'dom', 'm19', 'grn']

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
        next unless MTGA_SETS.include?(set)

        sets[set] ||= []
        sets[set] << card
      end

      transaction do
        self[:sets] = sets
      end
    end

    def sets
      transaction do
        self[:sets]
      end
    end
  end
end
