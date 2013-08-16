class CreateScoretypes < ActiveRecord::Migration
  def change
    create_table :scoretypes do |t|
      t.string :description

      t.timestamps
    end
  end
end
