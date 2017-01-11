require 'test_helper'

class UsersRegistrationTest < ActionDispatch::IntegrationTest
  test 'should not register' do
    get signup_path
    assert_select 'input[name=?]', 'user[name]'
    assert_select 'input[name=?]', 'user[password]'
    assert_select 'input[name=?]', 'user[password_confirmation]'
    assert_no_difference 'User.count' do
      post signup_path, user: { name: '', password: '', password_confirmation: '' }
    end
    assert_select '.error'
  end

  test 'should register' do
    user = User.new(name: 'aaaaaaaaaaa', password: '123456', password_confirmation: '123456')
    assert_difference 'User.count', 1 do
      post signup_path, user: { name: user.name,
                                password: user.password,
                                password_confirmation: user.password }
    end
    user = User.find_by(name: user.name)
    assert_select '.error', 0
    assert_redirected_to "/users/#{user.id}"
  end
end
