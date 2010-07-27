require File.expand_path('../../seed_data_loader', __FILE__)

task :parse  => :environment do
  puts starttime = Time.now
  Parser.parse!
  puts endtime = Time.now
  puts finaltime = endtime - starttime
  puts "Completed"
end

task :load_seed_data => :environment do
  SeedDataLoader.setup_seed_data!
end