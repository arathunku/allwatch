class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  include UsersHelper

  def ommit_if_logged
    redirect_to root_path if signed_in?
  end

  def correct_user?
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Zaloguj sie."
    end
  end
end
