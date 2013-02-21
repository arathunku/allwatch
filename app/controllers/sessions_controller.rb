#encoding: utf-8 
class SessionsController < ApplicationController
  before_filter :ommit_if_logged, only: [:new, :create]
  
  def new
  
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or root_url
    else
      flash[:error] = "Złe hasło/email. Aby zresetować hasło przejdz <a href='#{url_for(reset_index_path)}'>tutaj</a>".html_safe
      redirect_to root_url
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

end
