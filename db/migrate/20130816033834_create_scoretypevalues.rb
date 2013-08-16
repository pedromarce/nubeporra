class CreateScoretypevalues < ActiveRecord::Migration
  def change
    create_table :scoretypevalues do |t|
      t.string :value
      t.references :scoretype

      t.timestamps
    end
    add_index :scoretypevalues, :scoretype_id
  end
end
