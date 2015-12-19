require "test_helper"

feature "Admin User Can Access Blog Index" do
  before do
    logged_in_as users(:vic)
  end

  scenario "HP: Index of Blogs Renders" do
    visit blogs_path
    page.must_have_content 'Show'
    page.must_have_content 'Edit'
    page.must_have_content 'Destroy'

    within('tr', text: 'MyString') { click_link 'Show' }
    page.must_have_content 'MyString'
    page.must_have_link 'Edit'
    page.must_have_link 'Back'
  end
end

feature 'Registerd User Can Access Blog Index' do
  scenario 'HP: Visit Index and Blogs Render' do
  logged_in_as users(:shane)
  visit blogs_path
  page.wont_have_content 'Edit'
  page.wont_have_content 'Destroy'
  page.must_have_content 'Show'

  within('tr', text: 'MyString') { click_link 'Show' }
  page.must_have_content 'MyString'
  page.must_have_content 'Back'
  page.wont_have_content 'Edit'
  end
end

feature 'Guest User Can Not Access Blog Index' do
  scenario 'Guest Attept To Access Blogs Path' do
    visit blogs_path
    page.must_have_content 'You need to sign in or sign up before continuing.'
    visit blog_path blogs(:one)
    page.must_have_content 'Something Went Wrong. Contact Admin if you believe this an error'
  end
end


