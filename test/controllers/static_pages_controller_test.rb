require "test_helper"

class StaticPagesControllerTest < ActionController::TestCase
  def test_timeline
    get :timeline
    assert_response :success
  end

end
