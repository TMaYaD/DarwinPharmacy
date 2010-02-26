class PublicController < ApplicationController
  layout :select_layout

  private
  def select_layout
    current_user ? 'application' : 'public'
  end
end
