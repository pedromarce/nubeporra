class AddBoxingTable < ActiveRecord::Migration
  def change
  	  create_table :boxings do |t|
      t.string :description

      t.timestamps
    end
  end

end
