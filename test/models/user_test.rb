require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # digest from plain '123456'
  PASSWORD = '$2a$10$rCnzFVQE9aJ7cn45iH63LO7gm8ML.kIwfay8/s1ZLd7SCREI/IRn6'
             .freeze

  def setup
    @user = User.new(
      name: 'Some name',
      password: '123456',
      password_confirmation: '123456',
      access: 0
    )
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.name = '    '
    assert_not @user.valid?
  end

  test 'name should not be too long' do
    @user.name = 'a' * 256
    assert_not @user.valid?
  end

  test 'name should not be too short' do
    @user.name = 'a'
    assert_not @user.valid?
  end

  test 'name should be unique' do
    @user.name = 'admin'
    assert_not @user.valid?
  end

  test 'name should be unique and case-insensitive' do
    @user.name = 'AdmiN'
    assert_not @user.valid?
  end

  test 'should update' do
    user = users(:admin)
    assert user.save
  end

  test 'password should be present' do
    @user.password = nil
    assert_not @user.valid?
  end

  test 'password confirmation should be valid' do
    @user.password_confirmation = '1' * 6
    assert_not @user.valid?
  end
end
