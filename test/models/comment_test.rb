require "test_helper"

class CommentTest < ActiveSupport::TestCase
  def comment
    @comment ||= comments(:first_comment)
  end

  def test_valid
    assert comment.valid?
  end

  def test_comment_maximum_length_1000
    comment.body = 'a' * 999
    assert comment.valid?
  end

  def test_comment_greater_than_1000_invalid
    comment.body = 'a' * 1001
    refute comment.valid?
  end

  def test_comment_presence
    comment.body = ''
    refute comment.valid?
  end
end
