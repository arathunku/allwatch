#encoding: utf-8 
class LooksController < ApplicationController
  before_filter :correct_user?
  def show
    @looks = [current_user.looks.find_by_id(params[:id])]
    @auctions = @looks[0].auctions
  end

  def create
    # offer_type: 
    #  *0 - all auctions
    #  *1 - only BUY NOW 
    #  *2 - only Licytacje

    unless params_proper?(params[:look_for])
      respond_to do |format|
        flash[:error] = "Ceny muszą być liczbami nieujmnymi"
        format.html { redirect_to root_path }
        format.js { render js: "window.location = '/'"}
      end
      
    else
      #prepare - method in model
      @look = Look.prepare(current_user, params)
      if @look.save
        flash[:success] = "Aukcja dodana, za chwilę powinien przyjść e-mail."
        Allegro.check_for_new_auctions(@look.id) if Rails.env.production?
      else
        flash[:error] = "Coś poszło nie tak. Spróbuj ponownie lub skontaktuj się z administratorem."
      end
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js { render js: "window.location = '/'"}
      end
    end
  end

  def destroy
    @look = current_user.looks.find_by_id(params[:id])
    unless @look.destroy
      flash[:error] = "Coś poszło nie tak i niestety nie udało się usunąć."
    end
    redirect_to root_path
  end

  def refresh
    Allegro.check_for_new_auctions(params[:id])
    respond_to do |format|
      flash[:success] = "Za chwilę spis nowych aukcji będzie na adresie podanym przy rejestracji."
      format.html { redirect_to root_path }
      format.js { render js: "window.location = '/'"}
    end
    
  end

  def delete
    @look = Look.find_by_id(params[:id])
    redirect_to root_path if @look.nil?
  end

  private
    def params_proper?(p)
      #CORRECT tHIS!!!!!! 
      if p[:search_price_from].empty? && p[:search_price_to].empty?
        return true
      end
      if !p[:search_price_to].empty?
        if !is_numeric?(p[:search_price_to])
          return nil
        else
          if !p[:search_price_from].empty? && is_numeric?(p[:search_price_from])
            return p[:search_price_from].to_f <= p[:search_price_to].to_f && p[:search_price_from].to_f >= 0
          end
        end
      else
        if is_numeric?(p[:search_price_from])
           return p[:search_price_from].to_f >= 0
        else
          return nil
        end
      end
    end

    def is_numeric?(i)
      i.to_i.to_s == i || i.to_f.to_s == i
    end
end