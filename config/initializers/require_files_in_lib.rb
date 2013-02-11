Dir[Rails.root + 'lib/extras/**/*.rb'].each do |file|
  require file
end