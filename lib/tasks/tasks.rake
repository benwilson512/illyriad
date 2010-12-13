require File.expand_path('../../seed_data_loader', __FILE__)
require 'benchmark'

task :load_seed_data => :environment do
  SeedDataLoader.setup_seed_data!
end

desc 'Parses from the downloaded xml files'
namespace :parse do
  desc "Parse datafile_towns.xml"
  task :towns => :environment do
    puts Benchmark.measure {Parser.parse_towns!}
  end
  
  desc "Parse datafile_alliances.xml"
  task :alliances => :environment do
    puts Benchmark.measure {Parser.parse_alliances!}
  end
end