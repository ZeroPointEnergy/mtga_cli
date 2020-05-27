# Card DB related commands
#
module MtgaCli
  module Cli
    def self.command_collection(base)
      base.class_eval do
        desc 'Commands to interact with the collection database'
        command :collection do |c|

          c.desc 'Update the collection from the games output log'
          c.command :update do |sc|
            sc.action do |global_options,options,args|
              player_log = global_options[:player_log]
              help_now!('Please specify the path of the player log file') if player_log.nil?
              MtgaCli.collection_store.new_entry(player_log)
            end
          end

          c.desc 'Show the cards in the collection'
          c.command :show do |sc|
            sc.desc 'Only show cards from a specific set'
            sc.arg_name 'SET'
            sc.flag [:s, :set]

            sc.desc 'Only show cards with the given text in the card type'
            sc.arg_name 'TYPE'
            sc.flag [:t, :type]

            sc.action do |global_options,options,args|
              MtgaCli.collection_store.collection.show(options[:set], options[:type])
            end
          end

          c.desc 'Show a summary of the current collection'
          c.command :summary do |sc|
            sc.action do |global_options,options,args|
              MtgaCli.collection_store.collection.summary
            end
          end

          c.desc 'Show the history of changed cards between collection updates'
          c.command :history do |sc|
            sc.desc 'Show the history N updates back'
            sc.default_value 1
            sc.arg_name 'N'
            sc.flag [:n]

            sc.action do |global_options,options,args|
              MtgaCli.collection_store.history(options[:n].to_i)
            end
          end
        end
      end
    end
  end
end
