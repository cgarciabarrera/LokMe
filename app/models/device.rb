class Device < ActiveRecord::Base

  acts_as_gmappable :process_geocoding => false

  has_many :points
  validates :imei, :presence => true , :uniqueness => true
  belongs_to(:user)

  #attr_accessible :gmaps, :latitude, :longitude, :imei

  def latitude
    self.points.last.latitude if self.points.last.present?

  end

  def longitude
    self.points.last.longitude if self.points.last.present?

  end

  def accuracy
    self.points.last.accuracy if self.points.last.present?

  end

  def actualizado

    if self.points.last.present?
    ((Time.now - self.points.last.updated_at) *24*60*60).to_i
    end
  end

  def username
    self.user.name

  end

  def gmaps4rails_infowindow
    if self.name.present?
      "<h3>#{name}</h3>" + "<p>" + self.user.name.to_s + " " + self.accuracy.to_s + " metros</p>"

    else
      "<h3>#{imei}</h3>" + "<p>" + self.user.name.to_s + " " + self.accuracy.to_s + " metros</p>"
    end
  end

  def gmaps4rails_address
    "madrid"
  end

  def notificar(titulop, titulolargo, descripcion)
    require 'gcm'

    gcm = GCM.new("AIzaSyBAWSWMc8agoh7ZI9KqNnA2CDcZZIfVZ5I")
    registration_ids= [self.regid] # an array of one or more client registration IDs
    options = {data: {titulopq: titulop, titulolargo: titulolargo, descripcion: descripcion}, collapse_key: "updated_score"}
    response = gcm.send_notification(registration_ids, options)

  end


end
