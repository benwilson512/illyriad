class CreateSiegeForces < ActiveRecord::Migration
  def self.up
    create_table :siege_forces do |t|
      t.integer :siege_id
      t.integer :town_id
      t.integer :destination_x
      t.integer :destination_y
      t.string  :destination
      t.integer :troops
      t.string  :role
      t.string :speed
      t.datetime :arrival_time
      t.string :comments

      t.timestamps
    end
  end

  def self.down
    drop_table :siege_forces
  end
end
