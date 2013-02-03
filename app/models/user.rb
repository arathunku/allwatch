# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  has_secure_password
  has_many :looks, dependent: :destroy
  
  attr_accessor :search_string, :search_price_from, :search_price_to
  before_save { |user| user.email.downcase! }
  before_save :create_remember_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence:   true,
                    length:     { maximum: 128},
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, 
                       length:   { minimum: 6 }
  validates :password_confirmation, presence: true



  def change_password?(user)
    if self.authenticate(user[:password])
      unless user[:password_new] == user[:password_confirmation_new]
        return false
      end
      self.password_confirmation = user[:password_confirmation_new]
      self.password = user[:password_new]
      if save
        return true
      else
        return false
      end
    else
      return false
    end
  end

  private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
