require 'gli'
require 'mtga_cli/cli/global_options'

module MtgaCli
  module Cli
    include GLI::App
    extend self

    program_desc 'MTGA Collection CLI'
    version MtgaCli::VERSION

    subcommand_option_handling :normal
    arguments :strict

    config_file File.join(ENV['HOME'], '.config', 'mtga_cli.conf')

    global_options(self)

    pre do |global,command,options,args|
      ENV['GLI_DEBUG'] = 'true' if global[:trace] == true
      true
    end

    #command_db(self)
    #command_update(self)
    #command_collection(self)
  end
end
