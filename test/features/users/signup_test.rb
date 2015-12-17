require "test_helper"

feature "User Sign Up Validation" do

  scenario "HP: Home Path: Successful User Sign Up w/ Valid Input" do
    visit root_path
    page.must_have_link 'Join'
    assert_equal page.current_path, root_path
    click_link 'Join'
    assert_equal page.current_path, new_user_registration_path
    fill_in 'Email', with: 'testuser@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
    page.must_have_content 'Welcome!'
  end

  scenario 'HP: User Registration w/ common email formats' do
    common_valid_email_formats = %w( user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn )
    common_valid_email_formats.each do |valid|
      visit new_user_registration_path
      fill_in 'Email', with: valid
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_button 'Sign up'
      page.must_have_content 'Welcome!'
      click_link 'Logout'
    end
  end

  scenario 'HP: Edge Case for User Email/Password Length Validation' do
    visit new_user_registration_path
    email_length_80 = "a" * 68 + "@example.com"
    password_length_72 = "a" * 72
    fill_in 'Email', with: email_length_80
    fill_in 'Password', with: password_length_72
    fill_in 'Password confirmation', with: password_length_72
    click_button 'Sign up'
    page.must_have_content 'Welcome!'
  end

  scenario 'UHP: Invalid Email Format' do
    common_invalid_email_formats = %w( user@example,com user_at_foo.org user.name@example. )
    visit new_user_registration_path
    common_invalid_email_formats.each do |invalid|
      fill_in 'Email', with: invalid
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_button 'Sign up'
      page.must_have_content "Email is invalid"
    end
  end

  scenario 'UHP: Invalid Email Length Greater Than 80' do
    visit new_user_registration_path
    invalid_over_81 = "a" * 69 + "@example.com"
    fill_in 'Email', with: invalid_over_81
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
    page.must_have_content 'Email is too long (maximum is 80 characters)'
  end

  scenario 'UHP: Invalid Password Lengths < 8, > 72' do
    invalid_password_over_72 = "a" * 73
    invalid_passwords = %w( passwor ) << invalid_password_over_72
    invalid_passwords.each do |invalid|
      visit new_user_registration_path
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: invalid
      fill_in 'Password confirmation', with: invalid
      click_button 'Sign up'
      page.must_have_content '1 error prohibited this user from being saved:'
      page.must_have_content 'Password is too'
    end
  end

  scenario 'UHP: Empty Sign up Credentials' do
    visit new_user_registration_path
    click_button 'Sign up'
    page.must_have_content "Email can't be blank"
    page.must_have_content "Password can't be blank"
  end
end
