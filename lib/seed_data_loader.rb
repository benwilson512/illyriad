class SeedDataLoader
  
  def self.setup_seed_data!
    NearestCalculation.create :name => "Nearest Calculation",
                              :description => "Lists the nearest towns to a given town"
  end
  
end