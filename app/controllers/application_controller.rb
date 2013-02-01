class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  include UsersHelper

  def ommit_if_logged
    redirect_to root_path if signed_in?
  end
end
