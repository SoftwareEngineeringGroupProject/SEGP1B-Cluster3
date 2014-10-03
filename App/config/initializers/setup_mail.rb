ActionMailer::Base.smtp_settings = {
  :address 	=> "smtp.gmail.com",
  :port	   	=> 587,
  :domain	=> "localhost",
  :user_name => "PPMS@gmail.com",
  :password	=> "password",
  :authentication => "plain",
  :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "localhost:3000"
