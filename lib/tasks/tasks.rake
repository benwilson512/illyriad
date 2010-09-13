require File.expand_path('../../seed_data_loader', __FILE__)
require 'benchmark'

task :parse  => :environment do
  puts Benchmark.measure {Parser.parse!}
end

task :load_seed_data => :environment do
  SeedDataLoader.setup_seed_data!
end