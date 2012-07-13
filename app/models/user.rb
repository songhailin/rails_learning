class User < ActiveRecord::Base
  require 'digest/sha1'

  validates_presence_of :name
  validates_uniqueness_of :name

  attr_accessor :password_confirmation
  validates_confirmation_of :password

  validate :password_non_blank

  #  before_destroy :must_not_delete_last_user
  after_destroy :must_not_destroy_last_user

  def password
    @password
  end

  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password = User.encrypted_password(self.password,self.salt)
  end

  def self.authenticate(name,password)
    user = self.find_by_name(name)
    if user
      expected_password = encrypted_password(password,user.salt)
      if user.hashed_password != expected_password
        user = nil
      end
    end
    user
  end  

  def must_not_delete_last_user
    if self.class.count == 1
      raise "Can't delete last user"
    end
  end

  def must_not_destroy_last_user
    if User.count.zero?
      raise "Can't destroy last user"
    end
  end

  private
  def self.encrypted_password(password,salt)
    string_to_hash = password + 'wibble' + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end

  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end

  def password_non_blank
    errors.add(:password,'Missing password') if hashed_password.blank?
  end
end
