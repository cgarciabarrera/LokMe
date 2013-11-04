class Device < ActiveRecord::Base

  acts_as_gmappable :process_geocoding => false

  has_many :points
  validates :imei, :presence => true
  belongs_to(:user)

  #attr_accessible :gmaps, :latitude, :longitude, :imei

  def latitude
    self.points.last.latitude if self.points.last.present?

  end

  def longitude
    self.points.last.longitude if self.points.last.present?

  end


  def gmaps4rails_infowindow
    if self.name.present?
      "<h3>#{name}</h3>" + "<p>" + self.user.name + "</p>"

    else
      "<h3>#{imei}</h3>" + "<p>" + self.user.name + "</p>"
      end
  end

  def gmaps4rails_address
    "madrid"
  end


end
