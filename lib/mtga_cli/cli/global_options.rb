module MtgaCli
  module Cli
    def self.global_options(base)
      base.class_eval do
        desc 'Verbosity of the command line tool'
        default_value 'INFO'
        arg_name 'Verbosity'
        flag [:verbosity, :v]

        desc 'Show stacktrace on crash'
        default_value false
        switch [:trace, :t]

        desc 'Output log file of magic arena'
        default_value nil
        arg_name 'OUTPUT_LOG'
        flag [:output_log, :o]
      end
    end
  end
end

