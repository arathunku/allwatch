module AdminHelper
  
  def is_admin?
    unless current_user.nil?
      current_user.email == ENV['ADMIN_EMAIL']
    else
      false
    end
  end
end
