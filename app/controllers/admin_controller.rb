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
    user = User.find(params[:id])
    if user.email == ENV['ADMIN_EMAIL']
      flash[:warning] = "Nie możesz usunąć siebie."
      redirect_to admin_index_path and return
    end
    user.destroy
    flash[:success] = "Konto zostało usunięte."
    redirect_to admin_index_path
  end

  def look_delete
    @look = Look.find_by_id(params[:look_id])
    unless @look.destroy
      flash[:error] = "Coś poszło nie tak i niestety nie udało się usunąć tego."
    else
      flash[:notice] = "Usunięto, wszystko w porządku."
    end
    redirect_to admin_path(params[:id])
  end

  protected
  def admin?
    render_404 if current_user.email != ENV['ADMIN_EMAIL']
  end
end
