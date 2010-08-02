class CreateSieges < ActiveRecord::Migration
  def self.up
    create_table :sieges do |t|
      t.string      :name
      t.integer     :target_id
      t.datetime    :time
      t.string      :positions
      t.integer     :creator_id
      t.time        :reinforce_time_delta
      t.time        :clearing_force_time_delta
      t.string      :roles

      t.timestamps
    end
  end

  def self.down
    drop_table :sieges
  end
end
