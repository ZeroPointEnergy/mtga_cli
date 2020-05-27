# Inventory related commands
#
require 'yaml'

module MtgaCli
  module Cli
    def self.command_inventory(base)
      base.class_eval do
        desc 'Show user inventory information'
        command :inventory do |c|
          c.action do |global_options,options,args|
            player_log_file = global_options[:player_log]
            help_now!('Please specify the path of the player log file') if player_log_file.nil?
            player_log = PlayerLog.new(player_log_file)
            puts player_log.inventory.to_yaml
          end
        end
      end
    end
  end
end
