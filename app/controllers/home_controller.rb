class HomeController < ApplicationController
  def index
    #@users = User.all

    if user_signed_in?
      @devices= Device.where('user_id = ?', current_user.id)
    end
  end
end
