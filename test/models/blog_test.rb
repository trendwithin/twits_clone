require "test_helper"

class BlogTest < ActiveSupport::TestCase
  def blog
    @blog ||= blogs(:one)
  end

  def test_valid
    assert blog.valid?
  end

  def test_edge_case_for_title
    blog.title = ''
    refute blog.valid?
    blog.title = 'a' * 5001
    refute blog.valid?
  end

  def test_edge_case_for_body
    blog.body = ''
    refute blog.valid?
    blog.title = 'a' * 5001
    refute blog.valid?
  end
end
