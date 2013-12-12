class AddExternalIdToGames < ActiveRecord::Migration
  def change
    add_column :games, :externalid, :string
  end
end
