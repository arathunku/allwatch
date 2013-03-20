FactoryGirl.define do
  factory :user do
    email    "example@example.com"
    password "foobar"
    password_confirmation "foobar"
  end

  factory :look do
    name_query "garmin"
    look_query {'"search-string" => "garmin premium",
                       "search-limit" => 10'}
    user
  end

  factory :auction do
    look
    sequence(:name)      { |n| "garmin aukcja_#{n}" }
    sequence(:price_buy) { |n| n+100 }
    sequence(:auction_id) { |n| n }
    auction_type 1
    price_atm 0
    sequence(:end_time) { |n| Time.at(Time.now).utc }
  end
end