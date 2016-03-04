require "test_helper"

feature "Comments::CreateComment" do
  scenario "Registered Users can Create A Comment" do
    logged_in_as users(:shane)
    visit blog_path(blogs(:one))
    fill_in 'comment[body]', with: 'Adding a blog comment'
    click_button 'Add Comment'
    page.must_have_text 'Adding a blog comment'
    page.must_have_text 'shane@theshield.net'
  end

  scenario "Registerd Admin Can Create A Comment" do
    logged_in_as users(:vic)
    visit blog_path(blogs(:one))
    fill_in 'comment[body]', with: 'Responding To A Comment'
    click_button 'Add Comment'
    page.must_have_text 'Responding To A Comment'
    page.must_have_text 'vic@theshield.net'
  end
end

feature 'Invalid Comment Data' do
  scenario 'Comment Left Blank on Submission' do
    logged_in_as users(:vic)
    visit blog_path(blogs(:one))
    click_button 'Add Comment'
    page.must_have_text "Body can't be blank"
  end

  scenario 'Comment Length > 1000' do
    logged_in_as users(:vic)
    visit blog_path blogs(:one)
    fill_in 'comment[body]', with: "a" * 1001
    click_button 'Add Comment'
    page.must_have_text "Body is too long (maximum is 1000 characters)"
  end
end
