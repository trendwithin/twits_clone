require "test_helper"

feature "Verified and Signed in Users Creating Chirps" do
  scenario 'User signs in and creates a chirp' do
    logged_in_as users(:shane)
    visit timeline_path
    fill_in 'chirp_content', with: 'Peep Peep Peep!'
    click_button 'Post'
    page.must_have_content 'Peep Peep Peep!'
    page.must_have_content 'Message created!'
    page.find('li:first-child', text: 'Peep Peep Peep!')
  end
end
