require "test_helper"

class ChirpTest < ActiveSupport::TestCase
  def setup
    @user = users(:vic)
    @chirp = Chirp.new(content: 'Lorem', user_id: @user.id)
  end

  def test_valid
    assert @chirp.valid?
  end

  test 'content should be present' do
    @chirp.content = ''
    refute @chirp.valid?
  end

  test 'user id should be present' do
    @chirp.user_id = nil
    refute @chirp.valid?
  end

  test 'chirp length does not exceed 1000 characters' do
    @chirp.content = 'a' * 1001
    refute @chirp.valid?
  end

  test 'chirp length edge case 1000' do
    @chirp.content = 'a' * 1000
    assert @chirp.valid?
  end
end
