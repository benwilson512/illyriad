class SeedDataLoader
  
  def self.setup_seed_data!
    Alliance.create(:game_id => -1, :name => "No Alliance", :ticker => "N/A")
    # User.create(:password => "secret", :email => "benwilson512@gmail.com", :name => "Ben Wilson")
    
    NearestCalculation.create(:name => "Nearest Calculation", :description => "Find towns nearest to this one")
  end
  
end