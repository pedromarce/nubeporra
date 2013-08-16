class AddTypeToBet < ActiveRecord::Migration
  def change
    add_column :bets, :scoretype_id, :integer
  end
end
