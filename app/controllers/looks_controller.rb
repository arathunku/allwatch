class LooksController < ApplicationController
  before_filter :correct_user?
  def show
  	
  end

  def create
    unless params_proper?(params[:look_for])
      flash[:error] = "Cos poszlo nie tak"
      redirect_to user_path(current_user)
    else
      ActiveRecord::Base.include_root_in_json = false
      #ActiveSupport::JSON.decode(j).symbolize_keys
      @look = current_user.looks.new(name_query: params[:look_for][:search_string],
                                     look_query: ActiveSupport::JSON.encode(params[:look_for]))
      if @look.save
        flash[:notice] = "Dodalem"
        redirect_to user_path(current_user)
      else
        flash[:error] = "Cos poszlo nie tak"
        redirect_to user_path(current_user)
      end
    end
  end

  def destroy
    @look = current_user.looks.find_by_id(params[:id])
    unless @look.destroy
      flash[:notice] = "Cos poszlo nie tak i nie dalo sie usunac"
    end
    redirect_to user_path(current_user)
  end

  private
    def params_proper?(p)
      is_numeric?(p[:search_price_from]) && is_numeric?(p[:search_price_to])
    end
    def is_numeric?(i)
      i.to_i.to_s == i || i.to_f.to_s == i
    end
    def correct_user?
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Zaloguj sie."
      end
    end
end