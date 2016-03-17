require "test_helper"

feature "User Visits Timeline Chirps" do
  scenario "Chirps listed most recent first on the Timeline" do
    logged_in_as users(:vic)
    visit timeline_path
    page.must_have_content 'Timeline'
    id = chirps(:latest).id
    page.find('li:first-child', text: chirps(:latest).content)
  end
end
