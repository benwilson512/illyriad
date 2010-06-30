class RemoveCalculations < ActiveRecord::Migration
  def self.up
    drop_table :calculations
  end

  def self.down
  end
end
