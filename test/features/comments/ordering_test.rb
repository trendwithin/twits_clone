require "test_helper"

feature "Comments::Ordering" do
  scenario "Comments are ordered in desc order" do
    logged_in_as users(:vic)
    visit blog_path blogs(:one)
    fill_in 'comment[body]', with: 'Second to first'
    click_button 'Add Comment'
    fill_in 'comment[body]', with: 'This should be the first comment returned'
    click_button 'Add Comment'
    comments = blogs(:one).comments
    assert_equal 'This should be the first comment returned', Blog.first.comments.desc.first.body
  end
end
