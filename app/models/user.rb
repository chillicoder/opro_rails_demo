class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :zip, :phone_number, :twitter

  has_many :products


  def to_public_json(options = {})
    to_public_hash.to_json
  end

  def to_public_hash(options = {})
    user_hash = self.attributes
    user_hash.delete('email')
    user_hash.delete('encrypted_password')
    user_hash.delete('last_sign_in_ip')
    user_hash.delete('current_sign_in_ip')
    user_hash.delete('reset_password_token')
    user_hash
  end
end
