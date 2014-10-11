class UserMailer < ActionMailer::Base
  default from: 'UofAPPMS@gmail.com'

  def welcome_email(user)
  	@user = user
    mail(:to => "#{user.name} <#{user.email}>", :subject => 'Welcome to Our Website!')
  end

  def send_a_message(message, receipient, subject)
    @message = message
    @receipient = receipient
    @subject = subject
    mail(:to => "#{receipient.name} <#{receipient.email}>", :subject => subject)
  end
  
  def email_new_password(user, newpass)
  	@user = user
  	@newpass = newpass
  	mail(:to => "#{user.fname} #{user.lname} <#{user.email}>", :subject => 'Your PPMS Password has been Reset')
  end

end
