#encoding: utf-8 
class AdminController < ApplicationController
  before_filter :admin?
  def index
    @users = User.all
  end

  def show
    @user = User.find_by_id(params[:id])
    @looks = @user.looks
  end

  def destroy
    if current_user.email == ENV['ADMIN_EMAIL']
      flash[:warning] = "Nie możesz usunąć siebie."
      redirect_to admin_index_path and return
    end
    User.find(params[:id]).destroy
    flash[:success] = "Konto zostało usunięte."
    redirect_to admin_index_path
  end


  protected
  def admin?
    render_404 if current_user.email != ENV['ADMIN_EMAIL']
  end
end
