require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:team)
  end

  test 'login with invalid information' do
    get new_user_session_path
    assert_response :success

    post user_session_path, user: { name: '', password: '' }
    assert_response :success
    assert_not flash.empty?

    get new_user_session_path
    assert flash.empty?
  end

  test 'login with valid information and logout' do
    post user_session_path, user: { name: @user.name, password: '123456' }
    assert_redirected_to team_path
    follow_redirect!
    assert_select 'a[href=?]', destroy_user_session_path

    delete destroy_user_session_path
    assert_redirected_to new_user_session_path
    follow_redirect!
    assert_select 'a[href=?]', destroy_user_session_path, count: 0
  end
end
