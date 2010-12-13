class CreateRelationships < ActiveRecord::Migration
  def self.up
    create_table :relationships do |t|
      t.string  :type
      t.integer :game_id
      t.datetime :established
      t.integer   :proposer_id
      t.integer   :acceptor_id

      t.timestamps
    end
  end

  def self.down
    drop_table :relationships
  end
end
