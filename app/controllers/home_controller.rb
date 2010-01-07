class HomeController < ApplicationController
  layout :select_layout
  def index
    #render :layout => false
  end

  private
  def select_layout
    current_user ? 'application' : 'home'
  end
end
