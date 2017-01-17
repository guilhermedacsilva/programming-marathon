require 'test_helper'

class TeamRegisterForMarathonTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:team)
    sign_in(@user)
  end

  test 'should not has a marathon' do
    get team_path
    assert_response :success
    assert_select 'a[href=?]', my_marathon_path, 0
  end

  test 'should has a marathon' do
    @user.marathon = marathons(:one)
    @user.save
    get team_path
    assert_select 'a[href=?]', my_marathon_path, 1
  end

  test 'should not list closed marathons' do
    get team_path
    assert_select 'a[href=?]', /Register for:/, 0
  end

  test 'should list open marathons' do
    Marathon.update_all(can_register: true)
    get team_path
    assert_select 'a', /Register for:/, Marathon.count
  end

  test 'invalid register for marathon' do
    marathon = marathons(:one)
    put team_path, marathon: marathon.id
    follow_redirect!
    assert_select '.alert-danger', 1
    assert_select 'a[href=?]', my_marathon_path, 0
  end

  test 'valid register for marathon' do
    marathon = marathons(:one)
    marathon.update(can_register: true)
    put team_path, marathon: marathon.id
    follow_redirect!
    assert_select '.alert-success', 1
    assert_select 'a[href=?]', my_marathon_path, 1
  end
end
