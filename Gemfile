source 'https://rubygems.org'

gem 'rails', '3.2.11'
gem "bootstrap-sass", "~> 2.2.2.0"
gem "bcrypt-ruby", "~> 3.0.1"
gem 'faker', '1.0.1'
gem 'jquery-rails'
gem "mail", "~> 2.4.3"
gem 'rails-i18n'
gem 'client_side_validations'
gem 'execjs'
gem 'therubyracer'
gem 'whenever', :require => false
#ALLEGRO
gem "savon", "2.1.0"
gem "httpclient", "~> 2.3.2"
#-------------------

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :development, :test do
  #gem 'sqlite3'
  gem 'rspec-rails'
  gem 'guard'
  gem 'guard-spork'
  gem 'guard-rspec'
  gem 'spork'
  gem 'spork-rails', git: 'git://github.com/koriroys/spork-rails.git'
  gem 'debugger'
  gem "pg", "0.14.1"
end

group :test do
  gem "capybara", "2.0.2"
  gem 'rb-inotify', '~> 0.9'
  gem 'factory_girl_rails', '4.2.0'

end

group :production do
  gem "pg", "0.14.1"
end
group :development do
  gem "annotate", "2.5.0"
end
