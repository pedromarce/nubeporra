class CreateBets < ActiveRecord::Migration
  def change
    create_table :bets do |t|
      t.string :score1
      t.string :score2
      t.string :score3
      t.datetime :betTime

      t.timestamps
    end
  end
end
