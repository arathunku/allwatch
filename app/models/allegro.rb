class Allegro
  require 'date'
  def self.check_for_new_auctions(id=nil)
    allegro = AllegroAPI.new(login: ENV['ALLEGRO_LOGIN'], 
                      password: ENV['ALLEGRO_PASSWORD'],
                      webapikey: ENV['ALLEGRO_WEBAPIKEY']
                    )
    if id.nil?
      looks = Look.all
    else
      looks = [Look.find_by_id(id)]
    end
    looks.each do |l|
      hash_to_ask = ActiveSupport::JSON.decode(l[:look_query]).symbolize_keys
      hash_to_ask = hash_to_ask.each_with_object({}) do |(k,v), h|
        if v.is_number?
          v.to_i == v.to_f ? h[k.to_s.split('_').join('-')] = v.to_i : h[k.to_s.split('_').join('-')] = v.to_f
        else
          h[k.to_s.split('_').join('-')] = v 
        end
      end
      results = allegro.do_search(hash_to_ask)
      if results[:search_count].to_i > 0
        results[:search_array][:item].each do |item|
          name = item[:s_it_name]
          price_atm = item[:s_it_price] || 0
          price_buy = item[:s_it_buy_now_price] || 0
          price_atm = 0 if price_buy == price_atm
          end_time = Time.at(item[:s_it_ending_time].to_i).utc
          auction_id = item[:s_it_id]
          #debugger
          auction_type = offer_type?(price_atm, price_buy)
          r = l.auctions.where(auction_id: auction_id).first_or_initialize
          r.update_attributes(name: name, price_atm: price_atm, price_buy: price_buy, end_time: end_time, auction_type: auction_type)
        end
      end
      l.touch
    end
    send_notification_about_auctions
  end

  #temporary, later move it to the checking for auctions and simplify 
  def self.send_notification_about_auctions(id=nil)
    # Auction.where('auctions.updated_at == auctions.created_at')
    if id.nil?
      looks = Look.all
    else
      looks = [Look.find_by_id(id)]
    end
    looks.each do |l|
      body = l.auctions.where("auctions.updated_at = auctions.created_at AND auctions.end_time > '#{Time.now.strftime('%Y-%m-%d %H:%M:%S.000000')}' AND auctions.auction_type = #{l.offer_type}")
      if body.length != 0 
        user = User.find_by_id(l.user_id)
        Notifier.notification(user, l, body).deliver
        body.each { |b| b.touch }
      end
    end
    puts "Updated #{looks.length} looks"
  end

  def self.offer_type?(price_atm, price_buy)
    if price_atm == "0" && price_buy != "0"
      1
    elsif price_buy == "0" && price_atm != "0"
      2
    else
      0
    end
  end

end

class String
  def is_number?
    true if Float(self) rescue false
  end
end