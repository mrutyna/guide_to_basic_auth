class User < ActiveRecord::Base
  attr_reader :password #14

  validates :username, :session_token, presence: true, uniqueness: true #11
  validates :password_digest, presence: { message: "Password can't be blank" } #11, #12
  validates :password, length: { minimum: 6, allow_nil: true } #14

  def password=(password) #13
    @password = password #14 setting it during the password_setting to test validation
    self.password_digest = BCrypt::Password.create(password)
  end #13

  def is_password?(password) #13
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end #13
end
