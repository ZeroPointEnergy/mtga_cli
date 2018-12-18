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
      end
    end
  end
end

