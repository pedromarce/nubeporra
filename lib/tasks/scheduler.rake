desc "This task is called by the Heroku scheduler add-on"
task :close_games => :environment do
  puts "Closing games..."
  ScoreapisController.close_games
  puts "done."
end
