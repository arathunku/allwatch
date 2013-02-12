class UsersController < ApplicationController
  before_filter :correct_user?, only: [:edit, :update]
  before_filter :ommit_if_logged, only: [:new]


  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome!"
      redirect_to root_path
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
      redirect_to root_path
    else
      redirect_to root_path
      flash[:warning] = "Wrong password"
    end
  end


end
