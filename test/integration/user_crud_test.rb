require 'test_helper'

class UserCrudTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:admin)
    log_in_as(@user)
  end

  test 'should not delete the admin' do
    delete user_path(@user)
    assert_select '.alert-danger'
    assert User.find(@user.id)
  end

  test 'should delete' do
    user = users(:simple)
    delete user_path(user)
    assert_select '.alert-success'
    assert_not User.find_by(id: user.id)
  end
end
