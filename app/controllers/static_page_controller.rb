#encoding: utf-8 
class StaticPageController < ApplicationController
  def home
    if signed_in?
      @new_look = Look.new
      @looks = current_user.looks.all
    end
  end

  def about
  end
end
