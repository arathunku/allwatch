class LooksController < ApplicationController
  before_filter :correct_user?
  def show
    @looks = current_user.looks.find_by_id(params[:id])
    @auctions = @looks.auctions
  end

  def create
    unless params_proper?(params[:look_for])
      flash[:error] = "Cos poszlo nie tak"
      redirect_to root_path
    else
      @look = Look.prepare(current_user, params)
      if @look.save
        flash[:notice] = "Dodalem"
        redirect_to root_path
      else
        flash[:error] = "Cos poszlo nie tak"
        redirect_to root_path
      end
    end
  end

  def destroy
    @look = current_user.looks.find_by_id(params[:id])
    unless @look.destroy
      flash[:notice] = "Cos poszlo nie tak i nie dalo sie usunac"
    end
    redirect_to root_path
  end

  def refresh
    Allegro.check_for_new_auctions(params[:id])
    flash[:success] = "Za chwilę spis nowych aukcji będzie na adresie podanym przy rejestracji."
    redirect_to root_path
  end

  private
    def params_proper?(p)
      is_numeric?(p[:search_price_from]) && is_numeric?(p[:search_price_to])
    end
    def is_numeric?(i)
      i.to_i.to_s == i || i.to_f.to_s == i
    end
end