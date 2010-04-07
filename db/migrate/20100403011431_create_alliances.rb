class CreateAlliances < ActiveRecord::Migration
  def self.up
    create_table :alliances do |t|
      t.integer :game_id
      t.string :name
      t.string :ticker

      t.timestamps
    end
  end

  def self.down
    drop_table :alliances
  end
end
