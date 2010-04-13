class PublicController < ApplicationController
  layout :select_layout

  def stores
    @search = Franchise.search(params[:search])
    @franchises = @search.paginate(:page => params[:page])
  end

  private
  def select_layout
    current_user ? 'application' : 'public'
  end
end
