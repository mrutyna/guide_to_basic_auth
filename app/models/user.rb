class User < ActiveRecord::Base
  validates :username, :session_token, presence: true, uniqueness: true #10
  validates :password_digest, presence: true #10
end
