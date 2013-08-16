class AddTypeToGame < ActiveRecord::Migration
  def change
    add_column :games, :scoretype_id, :integer
  end
end
