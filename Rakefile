# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'tasks/rails'

desc 'Resets database with standalone seed data'
namespace :seed_data do
  desc "Load seed data with lib/SeedDataLoader into the current environment's database."
  task :load => "db:reset" do
    SeedDataLoader.setup_seed_data!
  end
end