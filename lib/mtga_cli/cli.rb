require 'gli'
require 'mtga_cli'
require 'mtga_cli/cli/global_options'
require 'mtga_cli/cli/command_db'
require 'mtga_cli/cli/command_collection'

module MtgaCli
  module Cli
    include GLI::App
    extend self

    program_desc 'MTGA Collection CLI'
    version MtgaCli::VERSION

    subcommand_option_handling :normal
    arguments :strict

    config_file File.join(MtgaCli.conf_dir, 'mtga_cli.conf')

    global_options(self)

    pre do |global,command,options,args|
      ENV['GLI_DEBUG'] = 'true' if global[:trace] == true
      true
    end

    command_db(self)
    command_collection(self)
  end
end
