require 'test_helper'

class UserCrudTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:admin)
    sign_in(@user)
  end

  test 'should not see delete button for admin' do
    get users_path
    assert_select 'tr:first-child .glyphicon-trash', 0
  end

  test 'should see delete button for team' do
    get users_path
    assert_select 'tr:nth-child(2) .glyphicon-trash'
  end

  test 'should not delete the admin' do
    delete user_registration_path(@user)
    follow_redirect!
    assert_select '.alert-danger'
    assert User.find(@user.id)
  end

  test 'should delete' do
    user = users(:team)
    delete user_registration_path(user)
    follow_redirect!
    assert_select '.alert-success'
    assert_not User.find_by(id: user.id)
  end
end
