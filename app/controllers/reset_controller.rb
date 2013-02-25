#encoding: utf-8 
class ResetController < ApplicationController
  before_filter :ommit_if_logged, only: [:index, :create, :show]

  require "base64"
  require "digest"
  require 'cgi'
  #handling subbmited new password id
  def update
    @user = User.find_by_id(params[:id])
    if @user
      if CGI.escape(Base64.strict_encode64(Digest::SHA256.new.digest(@user.password_digest))) != CGI.escape(params[:reset_token])
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
    if @user.reset_password?(params[:user])
      flash[:success] = "Hasło zostało zmienione. Można się zalogować."
      redirect_to root_path
    else
      redirect_to root_path
      flash[:warning] = "Coś poszło nie tak."
    end
  end

  #view with form for new password
  def show
    @user = User.find_by_id(params[:id])
    params[:reset_token] ||= ""
    if @user
      if CGI.escape(Base64.strict_encode64(Digest::SHA256.new.digest(@user.password_digest))) != CGI.escape(params[:reset_token])
        redirect_to root_path
      end
      @pass = CGI.escape(Base64.strict_encode64(Digest::SHA256.new.digest(@user.password_digest)))
    else
      redirect_to root_path
    end
  end

  #view where you put email
  def index
  end

  #handling subbmited email
  def create
    @user = User.find_by_email(params[:email].downcase)
    if @user
      @pass = CGI.escape(Base64.strict_encode64(Digest::SHA256.new.digest(@user.password_digest)))
      Notifier.password_reset(@user, @pass).deliver
    end
    flash[:success] = "Sprawdz pocztę."
    redirect_to root_path
  end
end