require "test_helper"

class ChirpsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @user = users(:vic)
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
end
