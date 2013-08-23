class AddBoxingToGame < ActiveRecord::Migration
  def change
    add_column :games, :boxing_id, :integer
  end
end
