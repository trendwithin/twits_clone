require "test_helper"

feature "Comments::UpdateComment" do
  scenario "Admin User Can Update Comment" do
    logged_in_as users(:vic)
    visit blog_path blogs(:one)
    id = comments(:first_comment).id
    within("[id=comment_#{id}]") do
      click_on 'Edit'
    end
    fill_in 'comment[body]', with: 'This Comment Has Been Updated'
    click_on 'Add Comment'
    page.must_have_content 'This Comment Has Been Updated'
  end

  scenario 'Registered User May Not Update Another Users Comment' do
    logged_in_as users(:shane)
    visit blog_path blogs(:one)
    id = comments(:second_comment).id
    within("[id=comment_#{id}]") do
      page.wont_have_link ('Edit')
    end

    visit edit_blog_comment_path(blogs(:one), comments(:second_comment))
    page.must_have_content 'Something Went Wrong. Contact Admin if you believe this an error'
  end
end
