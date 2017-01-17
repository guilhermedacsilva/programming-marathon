require 'test_helper'

class UsersRegistrationTest < ActionDispatch::IntegrationTest
  test 'should not register' do
    get new_user_registration_path
    assert_select 'input[name=?]', 'user[name]'
    assert_select 'input[name=?]', 'user[password]'
    assert_select 'input[name=?]', 'user[password_confirmation]'
    assert_no_difference 'User.count' do
      post new_user_registration_path,
           user: { name: '', password: '', password_confirmation: '' }
    end
    assert_select '.error'
  end

  test 'should register' do
    user = User.new(name: 'aaaaaaaaaaa',
                    password: '123456',
                    password_confirmation: '123456')
    assert_difference 'User.count', 1 do
      post user_registration_path,
           user: { name: user.name,
                   password: user.password,
                   password_confirmation: user.password }
    end
    user = User.find_by(name: user.name)
    assert_select '.error', 0
    assert_redirected_to team_path
  end
end
