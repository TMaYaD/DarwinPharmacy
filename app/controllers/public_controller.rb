class PublicController < ApplicationController
  layout :select_layout

  def stores
    @search = Store.search(params[:search])
    @stores = @search.paginate(:page => params[:page])
  end

  private
  def select_layout
    current_user ? 'application' : 'public'
  end
end
