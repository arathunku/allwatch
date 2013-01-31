# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
AllwatchSite::Application.initialize!

require 'bcrypt'
silence_warnings do
  BCrypt::Engine::DEFAULT_COST = BCrypt::Engine::MIN_COST
end