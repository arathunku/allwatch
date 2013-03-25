namespace :data do
  desc "Update auctions table in database"
  task update_auctions: :environment do
    puts "#{Time.now} Checking for new auctions..."
    Allegro.check_for_new_auctions
    #Allegro.send_notification_about_auctions
    puts "#{Time.now} - database updated without problems"
  end
end
