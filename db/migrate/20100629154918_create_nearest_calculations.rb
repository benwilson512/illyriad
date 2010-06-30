class CreateNearestCalculations < ActiveRecord::Migration
  def self.up
    create_table :nearest_calculations do |t|
      t.integer :subject_id
      t.integer :speed
      t.integer :time
      t.string :alliances
      
      t.string :results
      
      t.timestamps
    end
  end

  def self.down
    drop_table :nearest_calculations
  end
end
