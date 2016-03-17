require "test_helper"

class ChirpsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @user = users(:vic)
    @non_admin = users(:shane)
    @chirp = Chirp.new(content: 'Peep Peep')
  end

  test 'Chirps can not be created without logged in user' do
    refute_difference('Chirp.count') do
      post :create, chirp: { content: 'Peep' }
    end
  end

  test 'Chirps can not be destroyed without logged in user' do
    chirp = @user.chirps.build(content: 'save me!')
    chirp.save
    refute_difference('Chirp.count') do
      delete :destroy, { id: chirp }
    end
  end

  test 'Chirps can not be destroyed without Admin Role' do
    sign_in @non_admin
    chirp = @non_admin.chirps.build(content: 'You Can Not Delete Me!')
    chirp.save
    refute_difference('Chirp.count') do
      delete :destroy, { id: chirp }
    end
  end
  # commented out regression test to verify non admin deletion of chirps
  # test 'Chirps can be destroyed without Admin Role' do
  #   sign_in @non_admin
  #   chirp = @non_admin.chirps.build(content: 'I Can Be Deleted')
  #   chirp.save
  #   assert_difference('Chirp.count', -1) do
  #     delete :destroy, { id: chirp }
  #   end
  # end

  test 'Chirps can be destroyed with Admin Role' do
    sign_in @user
    chirp = @user.chirps.build(content: 'Valid for deletion')
    chirp.save
    assert_difference('Chirp.count', -1) do
      delete :destroy, { id: chirp }
    end
  end
end
