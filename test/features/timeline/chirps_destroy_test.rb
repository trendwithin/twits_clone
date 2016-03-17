require "test_helper"

feature "Admin User May Remove Chirps Form the Timeline" do
  scenario "Admin User Logs in and Deletes Chirp" do
    logged_in_as users(:vic)
    visit timeline_path
    fill_in 'chirp_content', with: 'Delete This Chirp!'
    click_button 'Post'
    page.must_have_content 'Delete This Chirp!'
    page.must_have_selector("ol#chirps li:nth-child(1)", text: 'Delete This Chirp!')
    within("ol#chirps li:nth-child(1)") do
      click_link 'Delete'
    end
    page.wont_have_content 'Delete This Chirp!'
  end

  scenario 'Users Will Not Have Access to Delete Link' do
    logged_in_as users(:shane)
    visit timeline_path
    page.wont_have_link 'Delete'
  end
end
