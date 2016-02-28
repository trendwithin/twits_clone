require "test_helper"

feature "Link Test" do
  scenario "Nav Bar Links" do
    logged_in_as users(:vic)
    visit root_path
    click_on 'Blog'
    assert current_path == blogs_path
  end
end
