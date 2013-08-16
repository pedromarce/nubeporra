class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :description
      t.string :score1
      t.string :score2
      t.string :score3
      t.datetime :closeTime
      t.datetime :gameTime

      t.timestamps
    end
  end
end
