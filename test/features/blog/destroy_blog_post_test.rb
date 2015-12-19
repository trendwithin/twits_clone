require "test_helper"

feature "Admin User Can Delete a Blog Post" do
  scenario "Admin Deletes Post" do
    logged_in_as users(:vic)
    visit blogs_path
    page.must_have_content 'MyString'
    within('tr', text: 'MyString') { click_link 'Destroy' }
    visit blogs_path
    page.wont_have_content 'MyString'
    page.wont_have_content 'MyText'
  end
end


