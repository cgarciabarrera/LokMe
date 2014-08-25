class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable
  has_many(:devices)

  has_many :shareds

  attr_accessible :username, :name, :email, :password, :password_confirmation, :remember_me, :locker_attributes

end
