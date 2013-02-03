namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    users = User.all(limit: 6)
    10.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.looks.create!(name_query: content, look_query: content.length.to_s) }
    end
  end
end
