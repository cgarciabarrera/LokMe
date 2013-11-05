class HomeController < ApplicationController
  def index2
    #@users = User.all

    if user_signed_in?
      @devices= Device.where('user_id = ?', current_user.id)
    end
  end

  def index

    if user_signed_in?
      #@devices=Device.all
      #@devices= Device.where('user_id = ?', current_user.id)

      @devices= Device.where('user_id = ?', current_user.id)

      @devicesmapa = Device.find_by_sql("select * from devices where user_id = " + current_user.id.to_s + " union select  * from devices where id in (select device_id from shareds where user_shared = " + current_user.id.to_s + ") ")

      @json       = @devicesmapa.to_gmaps4rails

      @jsonCirculos = "["
      @devicesmapa.each do |c|
        @jsonCirculos << "{"
        @jsonCirculos <<  "'lng':" + c.longitude.to_s + ", 'lat':" + c.latitude.to_s +  ", 'radius':" + c.accuracy.to_s + ", 'strokeColor': '#FF0000'"
        @jsonCirculos << "},"
      end
      @jsonCirculos << "]"

    end
  end
end
