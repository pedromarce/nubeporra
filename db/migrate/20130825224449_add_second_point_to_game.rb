class AddSecondPointToGame < ActiveRecord::Migration
  def change
    add_column :games, :secondpoint, :integer
  end
end
