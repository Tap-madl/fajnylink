class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable and :activatable
  devise :database_authenticatable, :registerable, #:confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :links, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation

end

