class AddTypeScoreToGame < ActiveRecord::Migration
  def change
    add_column :games, :typescore, :string
  end
end
