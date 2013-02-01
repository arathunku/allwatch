class UsersController < ApplicationController
  before_filter :correct_user?, only: [:show, :edit, :update]
  before_filter :ommit_if_logged, only: [:new]
  def show
    @user = User.find_by_id(params[:id])
    redirect_to root_path if @user.nil?
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome!"
      redirect_to @user
    else
      render 'new'
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
      redirect_to edit_user_path(@user)
    else
      redirect_to edit_user_path(@user)
      flash[:warning] = "Wrong password"
    end
  end


  private
    def correct_user?
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Zaloguj sie."
      end
    end
end
