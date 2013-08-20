class AddPointsToGame < ActiveRecord::Migration
  def change
    add_column :games, :numpoint, :integer
    add_column :games, :closed, :boolean
  end
end
