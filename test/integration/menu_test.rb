require 'test_helper'

class MenuTest < ActionDispatch::IntegrationTest
  test 'should see admin menu' do
    @user = users(:admin)
    log_in_as(@user)
    get marathons_path
    assert_select '#top-menu a[href=?]', marathons_path
    assert_select '#top-menu a[href=?]', user_path(@user)
    assert_select '#top-menu a[href=?]', users_path
    assert_select '#top-menu a[href=?]', team_path, 0
    assert_select '#top-menu a[href=?]', logout_path
  end

  test 'should see team menu' do
    @user = users(:team)
    log_in_as(@user)
    get team_path
    assert_select '#top-menu a[href=?]', marathons_path, 0
    assert_select '#top-menu a[href=?]', user_path(@user), 0
    assert_select '#top-menu a[href=?]', users_path, 0
    assert_select '#top-menu a[href=?]', team_path
    assert_select '#top-menu a[href=?]', logout_path
  end
end
