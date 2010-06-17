class AddPlayerIdToTowns < ActiveRecord::Migration
  def self.up
    add_column :towns, :player_id, :integer
  end

  def self.down
  end
end
