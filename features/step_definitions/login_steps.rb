CORRECT_EMAIL = 'lec1k2103@gmail.com'.freeze
CORRECT_PASS = 'testtest'.freeze

Given /^I am on login page$/ do
  Home.new.navigate_to_login_page
end

When /^I login with (.*?) as an email and (.*?) as a password with checked remember me$/ do |email, password|
  Login.new.log_in(email, password, true)
end

When /^I login with (.*?) as an email and (.*?) as a password with unchecked remember me$/ do |email, password|
  Login.new.log_in(email, password)
end

Given /^I login with correct credentials$/ do
  Home.new.navigate_to_login_page
  Login.new.log_in(CORRECT_EMAIL, CORRECT_PASS)
end

Then /^Log in should be succeeded$/ do
  expect(Web).to be_user_logged_in
end

Then /^Log in should be failed$/ do
  expect(Web).to be_login_failed
end
