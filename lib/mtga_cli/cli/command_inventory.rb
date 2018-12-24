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
            output_log_file = global_options[:output_log]
            help_now!('Please specify the path of the output log file') if output_log_file.nil?
            output_log = OutputLog.new(output_log_file)
            puts output_log.inventory.to_yaml
          end
        end
      end
    end
  end
end
