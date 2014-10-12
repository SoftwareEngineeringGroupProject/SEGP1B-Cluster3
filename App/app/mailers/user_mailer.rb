class UserMailer < ActionMailer::Base
  default from: 'UofAPPMS@gmail.com'


  def welcome_email(user)
  	@user = user
    mail(:to => "#{user.lname} <#{user.email}>", :subject => 'Welcome to Our Website!')
  end

  def reset_password_email(user)
    @user = user
    mail(:to => "#{user.lname} <#{user.email}>", :subject => 'Password Reset')
  end

  def send_a_message(message, receipient, subject, file)
    @message = message
    @receipient = receipient
    @subject = subject

    # Assign attachment from user's attached file
    attachments[file.original_filename] = file.read unless file == nil

    mail(:to => "#{receipient.lname} <#{receipient.email}>", :subject => subject)
  end
  
  def email_new_password(user, newpass)
  	@user = user
  	@newpass = newpass
  	mail(:to => "#{user.fname} #{user.lname} <#{user.email}>", :subject => 'Your PPMS Password has been Reset')
  end
  
  def email_signup_password(user, newpass)
  	@user = user
  	@newpass = newpass
  	@username = user.username
  	@fullname = "#{user.fname} #{user.lname}"
  	mail(:to => "#{user.fname} #{user.lname} <#{user.email}>", :subject => 'PPMS Account Created')
  end

end
