class User < ActiveRecord::Base

  validates_length_of :username, :within => 3..40
  #validates_length_of :hashed_password#, :within => 5..40
  validates_presence_of :username, :email, :hashed_password, :salt
  validates_uniqueness_of :username, :email
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Invalid email", :multiline => true

  def self.create_with_credentials(username, email, password)
    salt = SecureRandom.hex
    hashed_password = generate_hash(password, salt)

    self.create(
      username: username,
      email: email,
      salt: salt,
      hashed_password: hashed_password
    )
  end

  def self.verify_credentials(password, salt, hashed_password) 
	  hashed_password == self.generate_hash(password,salt)
  end	

  def self.generate_hash(password, salt) 
    digest = OpenSSL::Digest::SHA256.new
    digest.update(salt<<password)
    digest.to_s
  end

end
