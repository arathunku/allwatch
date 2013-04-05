#encoding: utf-8 
class UsersController < ApplicationController
  before_filter :correct_user?, only: [:edit, :update]
  before_filter :ommit_if_logged, only: [:new]


  def create
    @user = User.new(params[:user])
    #debugger
    if @user.save
      sign_in @user
      flash[:success] = "Hej! Zacznij coś obserwować, a po chwili dostaniesz email z aukcjami! Na początku zostanie wysłane maksymalnie 100 aukcji, a w kolejnych mailach tylko nowe."
      #begin
      #  Notifier.welcome_email(@user.email).deliver
      #rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
        #flash[:success] = "Konto zostało utworzone, niestety były problemy z wysłaniem email."
      #end
      redirect_to root_path
    else 
      flash[:error] = @user.errors.full_messages
      redirect_to signup_path
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
      flash[:success] = "Hasło zostało zmienione."
      sign_in @user
      redirect_to root_path
    else
      redirect_to root_path
      flash[:warning] = "Niepoprawne obecne hasło."
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Konto zostało usunięte."
    redirect_to root_path
  end

end
