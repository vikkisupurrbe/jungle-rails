class User < ApplicationRecord
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 3 }

  def self.authenticate_with_credentials(email, password)
    clean_email = email.strip.downcase
    user = User.find_by("lower(email) = ?", clean_email)
  
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end
  
end
