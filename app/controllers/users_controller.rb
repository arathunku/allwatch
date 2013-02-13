#encoding: utf-8 
class UsersController < ApplicationController
  before_filter :correct_user?, only: [:edit, :update]
  before_filter :ommit_if_logged, only: [:new]


  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome!"
      begin
        Notifier.welcome_email(@user.email).deliver
      rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
        flash[:success] = "Konto utworzone, niestety problemy z wysłaniem email"
      end
      redirect_to root_path
    else
      flash[:error] = "Wystąpił nieznany błąd."
      redirect_to root_path
    end
  end

  def new
      @user = User.new
  end

  def edit
  end

  def update
    @user = User.find_by_id(params[:id])
    if @user.change_password?(params[:user])
      flash[:notice] = "Password has been changed"
      @user = User.find_by_id(params[:id])
      sign_in @user
      redirect_to root_path
    else
      redirect_to root_path
      flash[:warning] = "Wrong password"
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Konto zostało usunięte"
    redirect_to root_path
  end

end
