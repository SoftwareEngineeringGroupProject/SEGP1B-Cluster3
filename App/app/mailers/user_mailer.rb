class UserMailer < ActionMailer::Base
  default from: 'UofA PPMS'

  def email_a_message(message, receipient, subject, file)
    @message = message
    @receipient = receipient
    @subject = subject

    # Assign attachment from user's attached file
    attachments[file.original_filename] = file.read unless file == nil

    mail(:to => "#{receipient.lname} <#{receipient.email}>", :subject => subject)
  end

  def email_message_to_multi_recipients(message, recipients, subject, file)

    @message = message
    @recipients = recipients
    @subject = subject

    # Assign attachment from user's attached file
    attachments[file.original_filename] = file.read unless file == nil

    mail(:to => recipients, :subject => subject)
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
  	mail(:to => "#{user.fname} #{user.lname} <#{user.email}>", :subject => 'PPMS Admin Account Created')
  end

  def email_signup_password_industry(user)
  	@user = user
  	@username = user.username
  	@fullname = "#{user.fname} #{user.lname}"
  	mail(:to => "#{user.fname} #{user.lname} <#{user.email}>", :subject => 'PPMS Account Created')
  end

end
