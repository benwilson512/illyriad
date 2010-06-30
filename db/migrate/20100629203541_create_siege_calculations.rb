class CreateSiegeCalculations < ActiveRecord::Migration
  def self.up
    create_table :siege_calculations do |t|
      t.integer :x
      t.integer :y
      t.string :attackers
      
      t.timestamps
      
    end
  end

  def self.down
  end
end
