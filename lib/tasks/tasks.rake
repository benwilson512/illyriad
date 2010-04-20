task :parse  => :environment do
  puts starttime = Time.now
  Parser.parse!
  puts endtime = Time.now
  puts finaltime = endtime - starttime
  puts "Completed"
end