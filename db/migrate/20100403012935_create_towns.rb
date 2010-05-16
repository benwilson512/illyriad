class CreateTowns < ActiveRecord::Migration
  def self.up
    create_table :towns do |t|
       t.string :name
       t.integer :x
       t.integer :y
       t.integer :population
       t.boolean :capital
       t.boolean :alliance_capital
       t.integer :game_id

       t.timestamps
     end
  end

  def self.down
    drop_table :towns
  end
end
