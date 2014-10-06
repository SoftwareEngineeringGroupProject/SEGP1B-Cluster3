class UserMailer < ActionMailer::Base
  default from: 'khanh.hb111@gmail.com'

  def welcome_email(user)
  	@user = user
    mail(:to => "#{user.lname} <#{user.email}>", :subject => 'Welcome to Our Website!')
  end

  def reset_password_email(user)
    @user = user
    mail(:to => "#{user.lname} <#{user.email}>", :subject => 'Password Reset')
  end

  def send_a_message(message, receipient, subject)
    @message = message
    @receipient = receipient
    @subject = subject
    mail(:to => "#{receipient.name} <#{receipient.email}>", :subject => subject)
  end

end
