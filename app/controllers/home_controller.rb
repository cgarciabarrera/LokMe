class HomeController < ApplicationController
  def index2
    #@users = User.all

    if user_signed_in?
      @devices= Device.where('user_id = ?', current_user.id)
    end
  end

  def index

    if user_signed_in?
      @devices=Device.all
      #@devices= Device.where('user_id = ?', current_user.id)

      @json       = @devices.to_gmaps4rails
    end
  end
end
