require 'test_helper'

class MenuTest < ActionDispatch::IntegrationTest
  test 'should see admin menu' do
    @user = users(:admin)
    sign_in(@user)
    get marathons_path
    assert_select '#top-menu a[href=?]', marathons_path
    assert_select '#top-menu a[href=?]', user_registration_path(@user)
    assert_select '#top-menu a[href=?]', users_path
    assert_select '#top-menu a[href=?]', team_path, 0
    assert_select '#top-menu a[href=?]', destroy_user_session_path
  end

  test 'should see team menu' do
    @user = users(:team)
    sign_in(@user)
    get team_path
    assert_select '#top-menu a[href=?]', marathons_path, 0
    assert_select '#top-menu a[href=?]', user_registration_path(@user), 0
    assert_select '#top-menu a[href=?]', users_path, 0
    assert_select '#top-menu a[href=?]', team_path
    assert_select '#top-menu a[href=?]', destroy_user_session_path
  end
end
