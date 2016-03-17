require "test_helper"

feature "Admin Can Create Blog Post" do
  before do
    logged_in_as users(:vic)
  end

  scenario "HP: Valid Title and Body" do
    visit new_blog_path
    fill_in 'Title', with: 'This is a new blog post'
    fill_in 'Body', with: 'This is a new body'
    click_button 'Create Blog'
    page.must_have_content 'This is a new blog post'
    page.must_have_content 'This is a new body'
  end

  scenario 'HP: Title < 50 chars, Body < 5000 chars' do
    visit new_blog_path
    title_50 = 'a' * 50
    body_5000 = 'a' * 5000
    fill_in 'Title', with: title_50
    fill_in 'Body', with: body_5000
    click_button 'Create Blog'
    page.must_have_content title_50
    page.must_have_content body_5000
  end

  scenario 'UHP: Title > 50 Characters Not Allowed' do
    visit new_blog_path
    title_51 = 'a' * 51
    body_5000 = 'a' * 5000
    fill_in 'Title', with: title_51
    fill_in 'Body', with: body_5000
    click_button 'Create Blog'
    page.must_have_content 'Title is too long'
    page.must_have_content 'The form contains 1 error.'
  end

  scenario 'UHP Body > 5000 Characters Not Allowed' do
    visit new_blog_path
    title_50 = 'a' * 50
    body_5001 = 'a' * 5001
    fill_in 'Title', with: title_50
    fill_in 'Body', with: body_5001
    click_button 'Create Blog'
    page.must_have_content 'Body is too long'
    page.must_have_content 'The form contains 1 error.'
  end

  scenario 'UHP: Title and Body Empty' do
    visit new_blog_path
    click_button 'Create Blog'
    page.must_have_content 'The form contains 2 errors.'
  end
end

feature 'Non-Admin Users Can Not Create a Blog Post' do

  scenario 'Non Signed In User Redirected to Sign in When Accessing New Blog Path' do
    visit new_blog_path
    assert_equal page.current_path, new_user_session_path
  end

  scenario 'Registered Users May Not Access Create for Blog Post' do
    logged_in_as users(:shane)
    current_page = page.current_path
    visit new_blog_path
    page.current_path == root_path || current_page
  end
end
