require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  test 'login with invalid information' do
    get login_path
    assert_response :success

    post login_path, session: { name: '', password: '' }
    assert_response :success
    assert_not flash.empty?

    get root_path
    assert flash.empty?
  end

  test 'login with valid information and logout' do
    user = User.first
    post login_path, session: { name: user.name, password: '123456' }
    assert_redirected_to user
    assert logged_in?

    delete logout_path
    assert_redirected_to login_path
    assert_not logged_in?
  end
end
