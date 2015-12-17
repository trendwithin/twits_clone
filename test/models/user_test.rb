# require "test_helper"

class UserTest < ActiveSupport::TestCase
  def user
    @user ||= users(:shane)
  end

  def test_valid
    assert user.valid?
  end

  def test_email_is_valid_between_5_and_80_characters
    email_5 = "a@b.c"
    email_80 = "a" * 68 + "@example.com"
    user.email = email_5
    assert user.valid?
    user.email = email_80
    assert user.valid?
  end

  def test_email_is_valid_less_than_4_greater_than_80_characters
    email_4 = 'ab.c'
    email_81 = "a" * 69 + "@example.com"
    user.email = email_4
    refute user.valid?
    user.email = email_81
    refute user.valid?
  end

  def test_blank_email_and_password_invalid
    user.email = ''
    refute user.valid?
    user.password = ''
    refute user.valid?
  end

  def test_user_name_length_less_than_50
    user.name = 'a' * 51
    refute user.valid?
  end
end
