class User < ActiveRecord::Base
  attr_accessor :password
  before_save :password_encrypt

  validates_confirmation_of :password
  validates_presence_of :password, on: :create
  validates_presence_of :email, on: :create
  validates_uniqueness_of :email

  def password_encrypt
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def self.authenticate_user(email,password)
    log_in_user = find_by_email(email)
    if log_in_user && log_in_user.password_hash == BCrypt::Engine.hash_secret(password, log_in_user.password_salt)
      log_in_user
    else
      nil
    end
  end

end
