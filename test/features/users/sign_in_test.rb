require "test_helper"

feature "Users::SignIn" do
  scenario "User signs in with valid credentials" do
    visit root_path
    click_link 'Sign in'
    page.must_have_content 'Log in'
    fill_in 'Email', with: users(:shane).email
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    page.must_have_content 'Signed in successfully.'
  end

  scenario 'User enters incorrect credentials' do
    visit new_user_session_path
    fill_in 'Email', with: 'invaliduser@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    page.must_have_content 'Invalid email or password.'
  end
end
