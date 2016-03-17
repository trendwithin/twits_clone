require "test_helper"

class StaticPagesControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  def test_timeline
    sign_in users(:vic)
    get :timeline
    assert_response :success
  end

end
