require "test_helper"

feature "Comments::DestroyComments" do
  scenario "Admin Can Delete Comments" do
    logged_in_as users(:vic)
    visit blog_path blogs(:one)
    id = comments(:first_comment).id
    within("[id=comment_#{id}]") do
      click_on 'Destroy'
    end
    page.wont_have_text comments(:first_comment).user.email
    page.must_have_text 'Comment Removed.'
  end
end
