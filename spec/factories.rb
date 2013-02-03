FactoryGirl.define do
  factory :user do
    email    "michael@example.com"
    password "foobar"
    password_confirmation "foobar"
  end

  factory :look do
    name_query "garmin"
    look_query {'"search-string" => "garmin premium",
                       "search-limit" => 10'}
    user
  end
end