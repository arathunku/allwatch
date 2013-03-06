module AuctionsHelper
  def avg(auctions)
    sum = 0.0
    auctions.each do |a|
      sum += a.get_price
    end
    auctions.length != 0 ? (sum/auctions.length.to_f).round(2) : 0
  end

  def mediana(auctions)
    i = (auctions.length).to_f / 2
    return 0 if auctions.length == 0
    auctions.length.odd? ? auctions[i].get_price : (auctions[i].get_price + auctions[i+1].get_price) / 2.0
  end

  def sample_variance(auctions)
    prices = []
    auctions.each {|a| prices << a.get_price}
    #debugger
    avg = avg(auctions)
    sum = prices.inject(0){|acc,i|acc +(i-avg)**2}
    sum/(auctions.length-1).to_f
  end
  
  def std_dev(auctions)
    Math.sqrt(sample_variance(auctions)).round(2)
  end
end