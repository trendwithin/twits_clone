require "test_helper"

class CommentsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def comment
    @comment ||= comments(:first_comment)
  end

  def test_posting_comments_is_not_open_to_visitors
    refute_difference('Comment.count') do
      post :create, { blog_id: blogs(:one), comment: { body: comment.body} }
    end
  end

  def test_admin_can_comment_on_blog
    sign_in users(:vic)
    assert_difference('Comment.count') do
      post :create, { blog_id: blogs(:one), comment: { body: comment.body} }
    end
  end

  def test_registerd_users_can_not_delete_post
    sign_in users(:shane)
    refute_difference('Comment.count') do
      delete :destroy, id: comment, blog_id: comment.blog_id
    end
  end
end
