require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.first
  end

  test 'login with invalid information' do
    get new_user_session_path
    assert_response :success

    post user_session_path, session: { name: '', password: '' }
    assert_response :success
    assert_not flash.empty?

    get new_user_session_path
    assert flash.empty?
  end

  test 'login with valid information and logout' do
    post user_session_path, session: { name: @user.name, password: '123456' }
    assert_redirected_to team_path
    assert user_signed_in?
    follow_redirect!
    assert_select 'a[href=?]', destroy_user_session_path

    delete destroy_user_session_path
    assert_redirected_to login_path
    assert_not user_signed_in?
    follow_redirect!
    assert_select 'a[href=?]', destroy_user_session_path, count: 0

    delete destroy_user_session_path # second logout
  end
end
