namespace :data do
  desc "Update auctions table in database"
  task update_auctions: :environment do
    puts "Checking for new auctions..."
    Allegro.check_for_new_auctions
    puts "Database updated without problems"
  end
end
