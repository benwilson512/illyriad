class AllianceInfo < ActiveRecord::Migration
  def self.up
    add_column  :alliances,  :founder_id,       :integer
    add_column  :alliances,  :capital_id,       :integer
    add_column  :alliances,  :founded,          :datetime
    add_column  :alliances,  :tax_rate,         :float
    add_column  :alliances,  :set_tax_date,     :datetime
    add_column  :alliances,  :total_population, :integer
  end

  def self.down
    remove_column  :alliances,  :founder_id
    remove_column  :alliances,  :capital_id       
    remove_column  :alliances,  :founded        
    remove_column  :alliances,  :tax_rate
    remove_column  :alliances,  :set_tax_date
    remove_column  :alliances,  :total_population
  end
end
