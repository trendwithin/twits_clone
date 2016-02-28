require "test_helper"

feature "Comments::CreateComment" do
  scenario "Registered Users can Create A Comment" do
    logged_in_as users(:shane)
    visit blog_path(blogs(:one))
    save_and_open_page
    fill_in 'Body', with: 'Adding a blog comment'
    click_button 'Add Comment'
    page.musth_have_text 'Adding a blog comment'
  end
end
