
def log_in(user, options={})
  visit '/login'
  fill_in "Username/Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "LOG IN"
end