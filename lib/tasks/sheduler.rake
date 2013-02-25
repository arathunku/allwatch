task update_auctions: :environment do
  puts "Checking for new auctions..."
  Allegro.check_for_new_auctions
  #Allegro.send_notification_about_auctions
  puts "Database updated without problems"
end