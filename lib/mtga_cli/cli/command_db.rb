# Card DB related commands
#
module MtgaCli
  module Cli
    def self.command_db(base)
      base.class_eval do
        desc 'Commands to interact with the card database'
        command :db do |c|

          c.desc 'Import a json bulk data file from scryfall'
          c.arg_name 'JSON_FILE'
          c.command :import do |sc|
            sc.action do |global_options,options,args|
              help_now!('Please specify a json data file to import') if args.empty?
              json_file = args[0]
              MtgaCli.card_db.import(json_file)
            end
          end
        end
      end
    end
  end
end
