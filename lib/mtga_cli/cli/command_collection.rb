# Card DB related commands
#
module MtgaCli
  module Cli
    def self.command_collection(base)
      base.class_eval do
        desc 'Commands to interact with the collection database'
        command :collection do |c|

          c.desc 'Update the collection from the games output log'
          c.arg_name 'OUTPUT_LOG'
          c.command :update do |sc|
            sc.action do |global_options,options,args|
              help_now!('Please specify the path of the output log file') if args.empty?
              output_log = args[0]
              MtgaCli.collection_store.new_entry(output_log)
            end
          end

          c.desc 'Show the cards in the collection'
          c.command :show do |sc|
            sc.desc 'Only show cards from a specific set'
            sc.arg_name 'SET'
            sc.flag [:s, :set]

            sc.action do |global_options,options,args|
              MtgaCli.collection_store.collection.show(options[:set])
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
            sc.default_value 10
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
