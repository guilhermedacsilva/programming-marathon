require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'Monica', password: '123456', access: 0)
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
    @user.name = 'Fernando'
    assert_not @user.valid?
  end

  test 'password should be present' do
    @user.password = nil
    assert_not @user.valid?
  end

  test 'password should not be too long' do
    @user.password = 'a' * 256
    assert_not @user.valid?
  end
end
