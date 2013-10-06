class Device < ActiveRecord::Base
  has_many :points
  validates :imei, :presence => true
  belongs_to(:user)
end
