class RemoveTypeScores < ActiveRecord::Migration
  def change
    remove_column :games, :scoretype_id
    drop_table :scoretypes
    drop_table :scoretypevalues
  end
end
