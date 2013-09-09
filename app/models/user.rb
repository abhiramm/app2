class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,:invitable
  # :lockable, :timeoutable and :omniauthable
  devise  :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :performer
 # validates_presence_of :location
  accepts_nested_attributes_for :performer
  
  
end
