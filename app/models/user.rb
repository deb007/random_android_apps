require 'digest/sha1'

class User < ActiveRecord::Base
  has_many :teams

  validates_presence_of :user_id, :password, :salt, :full_name, :mail, :mobile, :city, :country
  validates_uniqueness_of :user_id, :mail
  validates_length_of :user_id, :within => 6..40
  validates_length_of :password, :within => 6..40
  validates_length_of :full_name, :within => 5..255
  validates_length_of :mail, :within => 5..255
  validates_length_of :mobile, :within => 6..15
  validates_length_of :telephone_number, :within => 0..15
  validates_length_of :country, :within => 3..100
  validates_confirmation_of :password
  validates_format_of :mail, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Invalid email"

  attr_protected :id, :salt
  attr_accessor :password

  scope :user_basic_details, lambda { |user_name| where(:user_id => user_name.downcase)}
  ##########
  #Methods
  ##########

  def password=(pass)
    @password=pass
    self.salt = User.random_string(10) if !self.salt?
    self.hashed_password = User.encrypt(@password, self.salt)
  end

  def send_new_password
    if !self.domain.nil? && self.domain == 'Manual'
      new_pass = User.random_string(10)
      #p new_pass
      self.password = self.password_confirmation = new_pass
      self.save
      Emails.forgot_password(self.mail, self.user_id, new_pass).deliver
      ret = true
    else
      ret = false
    end
    ret
  end

  class << self
    #include Authenticate

    def random_string(len)
      #generate a random password consisting of strings and digits
      chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
      newpass = ""
      1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
      return newpass
    end

    def encrypt(pass, salt)
      Digest::SHA1.hexdigest(pass+salt)
    end

    def authenticate(login, pass)
      u = find(:first, :conditions=>["user_id = ?", login])
      return nil if u.nil?
      return u if User.encrypt(pass, u.salt)==u.hashed_password
      nil
    end

  end

end
