# Global config stuff
module MtgaCli
  def self.conf_dir
    File.join(ENV['HOME'], '.config')
  end

  def self.conf_file
    File.join(conf_dir, 'mtga_cli.yaml')
  end

  def self.data_dir
    File.join(ENV['HOME'], '.local', 'share', 'mtga_cli')
  end
end
