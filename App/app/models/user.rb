class User < ActiveRecord::Base

#Perform validations
  #validates :username, length: { in: 4..40 }
  #validates :username, presence: true
  #validates :username, uniqueness: true
  
  #validates :email, presence: true
  #validates :email, uniqueness: true
  #validates :email, format: { with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
  #							message: "Invalid email", :multiline => true }
  
  #validates :password, presence: true
  #validates :password, length: { in: 4..40 }
  #validates :password, confirmation: true
  
  #validates :confirm_password, presence: true
  
#Called on creation of new user
  def self.create_with_credentials(username, email, password)
    salt = SecureRandom.hex
    hashed_password = generate_hash(password, salt)

    theuser = User.create(
      username: username,
      email: email,
      salt: salt,
      hashed_password: hashed_password
    )
    #theuser = User.new
    #theuser.username = username
    #theuser.email = email
    #theuser.hashed_password = hashed_password
    #theuser.salt = salt
    #return theuser.save
  end

  def self.verify_credentials(password, salt, hashed_password) 
	  return (hashed_password == self.generate_hash(password,salt))
  end	

  def self.generate_hash(password, salt) 
    digest = OpenSSL::Digest::SHA256.new
    digest.update(salt<<password)
    return digest.to_s
  end

end
