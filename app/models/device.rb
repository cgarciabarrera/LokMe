class Device < ActiveRecord::Base

  acts_as_gmappable :process_geocoding => false

  has_many :points
  validates :imei, :presence => true
  belongs_to(:user)

  #attr_accessible :gmaps, :latitude, :longitude, :imei

  def latitude
    self.points.last.latitude

  end

  def longitude
    self.points.last.longitude

  end


  def gmaps4rails_infowindow
    if self.name.present?
      "<h1>#{name}</h1>"
    else
      "<h1>#{imei}</h1>"
      end
  end

  def gmaps4rails_address
    "madrid"
  end

end
