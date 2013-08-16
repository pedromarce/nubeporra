class AddRefsToBet < ActiveRecord::Migration
  def change
    add_column :bets, :user_id, :integer
    add_column :bets, :game_id, :integer
  end
end
