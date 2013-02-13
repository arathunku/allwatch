class Mailer < ActionMailer::Base

  def initialize
    ActionMailer::Base.smtp_settings = {
        :port =>           '587',
        :address =>        'smtp.mandrillapp.com',
        :user_name =>      ENV['MANDRILL_USERNAME'],
        :password =>       ENV['MANDRILL_APIKEY'],
        :domain =>         'heroku.com',
        :authentication => :plain
    }
    ActionMailer::Base.delivery_method = :smtp
  end

  def deliver(send_to, subject, html)

  end
end

Z01-56w
Z04-05b