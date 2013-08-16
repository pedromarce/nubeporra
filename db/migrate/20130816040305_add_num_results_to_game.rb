class AddNumResultsToGame < ActiveRecord::Migration
  def change
    add_column :games, :numscore, :integer
  end
end
