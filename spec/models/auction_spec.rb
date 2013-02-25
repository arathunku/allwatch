# == Schema Information
#
# Table name: auctions
#
#  id         :integer          not null, primary key
#  look_id    :integer
#  name       :string(255)
#  price_atm  :decimal(10, 3)
#  price_buy  :decimal(10, 3)
#  end_time   :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  auction_id :integer
#  type       :integer          default(0)
#

require 'spec_helper'

describe Auction do
  pending "add some examples to (or delete) #{__FILE__}"
end
