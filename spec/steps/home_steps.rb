module HomeSteps
  step 'I am on home page' do
    Home.new
  end

  step 'I click on login button' do
    Home.new.navigate_to_login_page
  end

  step 'I should be redirected to login page' do
    expect(Web.current_page).to be_a(Login)
  end

  step 'I click on logout button' do
    Home.new.logout
  end

  step 'I should be logged out' do
    expect(Web).not_to be_user_logged_in
  end
end

RSpec.configure { |c| c.include HomeSteps }
