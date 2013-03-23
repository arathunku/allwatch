class UpdateAuctionsTask < Scheduler::SchedulerTask
  environments :production
  # environments :staging, :production
  
  every '10m'
  # other examples:
  # every '24h', :first_at => Chronic.parse('next midnight')
  # cron '* 4 * * *'  # cron style
  # in '30s'          # run once, 30 seconds from scheduler start/restart
  
  
  def run
    puts "Checking for new auctions..."
    Allegro.check_for_new_auctions
    #Allegro.send_notification_about_auctions
    puts "Database updated without problems"
  end
end
