#encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  include AdminHelper
  include SessionsHelper
  include UsersHelper
  include AuctionsHelper
  def ommit_if_logged
    redirect_to root_path if signed_in?
  end

  def correct_user?
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Musisz się najpierw zalogować."
    end
  end
  
  def render_404
    raise ActionController::RoutingError.new('Nie ma takiej strony.')
  end

end
