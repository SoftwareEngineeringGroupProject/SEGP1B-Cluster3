class UserMailer < ActionMailer::Base
  default from: 'PPMS@gmail.com'

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

end