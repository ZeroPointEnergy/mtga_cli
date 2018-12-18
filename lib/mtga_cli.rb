require 'mtga_cli/version'
require 'mtga_cli/config'
require 'mtga_cli/db'
require 'mtga_cli/collection_store'
require 'mtga_cli/collection'

module MtgaCli
  def self.card_db
    @card_db ||= MtgaCli::Db.new
  end

  def self.collection_store
    @collection_store ||= MtgaCli::CollectionStore.new
  end
end
