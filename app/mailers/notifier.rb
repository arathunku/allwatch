class Notifier < ActionMailer::Base
  default from: "allwatch@arathunku.com"
  
  #-----initializers hidden from source code----#
  #ActionMailer::Base.delivery_method = :smtp
  #ActionMailer::Base.smtp_settings = {
  #  :port =>           '587',
  #  :address =>        'smtp.mandrillapp.com',
  #  :user_name =>      ENV["MANDRILL_USERNAME"],
  #  :password =>       ENV["MANDRILL_PASSWORD"],
  #  :authentication => 'plain',
  #  :enable_starttls_auto => true
  #}
  #---------------------------------------------#
  def welcome_email(to)
    headers['X-MC-Autotext'] = 'true'
    headers['X-MC-Tags'] = 'welcome'

    mail(to: to, subject: "Witaj - allwatch!") do |format|
      format.html
    end
  end

  def notification(user, look, body)
    headers['X-MC-Autotext'] = 'true'
    headers['X-MC-Tags'] = 'notification'
    @auctions = body
    @look = look
    @user = user
    mail(to: user.email, subject: "\"#{look.name_query}\" -- nowe aukcje") do |format|
      format.html
      format.text
    end
  end

  def password_reset(user, pass)
    headers['X-MC-Autotext'] = 'true'
    headers['X-MC-Tags'] = 'password_reset'

    @user = user
    @pass = pass

    mail(to: user.email, subject: "allWatch - password reset ") do |format|
      format.html
      format.text
    end

  end
end
