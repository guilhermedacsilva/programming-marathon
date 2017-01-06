require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.first
  end

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
    post login_path, session: { name: @user.name, password: '123456' }
    assert_redirected_to @user
    assert logged_in?
    follow_redirect!
    assert_select 'a[href=?]', logout_path

    delete logout_path
    assert_redirected_to login_path
    assert_not logged_in?
    follow_redirect!
    assert_select 'a[href=?]', logout_path, count: 0

    delete logout_path # second logout
  end

  test 'login with remembering' do
    log_in_as(@user, remember_me: '1')
    assert_not_empty cookies['remember_token']
  end

  test 'login without remembering' do
    log_in_as(@user, remember_me: '1')
    delete logout_path
    log_in_as(@user, remember_me: '0')
    assert_empty cookies['remember_token']
  end
end
