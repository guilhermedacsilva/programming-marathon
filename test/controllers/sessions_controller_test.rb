require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should destroy' do
    delete :destroy
    assert_response :redirect
  end
end
