
Given /^I am on home page$/ do
  Home.new
end

When /^I click on login button$/ do
  Home.new.navigate_to_login_page
end

Then /^I should be redirected to login page$/ do
  expect(Web.current_page).to be_a(Login)
end

When /^I click on logout button$/ do
  Home.new.logout
end

Then /^I should be logged out$/ do
  expect(Web).not_to be_user_logged_in
end
