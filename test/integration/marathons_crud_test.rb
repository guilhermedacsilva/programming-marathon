require 'test_helper'

class MarathonsCrudTest < ActionDispatch::IntegrationTest
  def setup
    log_in_as(users(:admin))
  end

  test 'should load empty index' do
    Marathon.delete_all
    get marathons_path
    assert_response :success
    assert_select 'tr td:first-child', 'No records found'
  end

  test 'should index load only openned' do
    logout
    log_in_as(users(:simple))
    assert Marathon.count > 1
    get marathons_path
    assert_response :success
    assert_select 'tr', 2
    assert_select 'tr td:nth-child(2)', marathons(:one).name
  end

  test 'should index load all' do
    count = Marathon.count
    assert count > 1
    get marathons_path
    assert_response :success
    assert_select 'tr', count + 1
    assert_select 'td', marathons(:one).name
    assert_select 'td', marathons(:two).name
  end

  test 'should not access' do
    logout
    log_in_as(users(:simple))
    marathon = Marathon.first
    assert_no_difference 'Marathon.count' do
      get new_marathon_path
      assert_response :redirect, 'accessed new path'
      get edit_marathon_path(marathon)
      assert_response :redirect, 'accessed edit path'
      post marathons_path
      assert_response :redirect, 'accessed post path'
      patch marathon_path(marathon)
      assert_response :redirect, 'accessed patch path'
      delete marathon_path(marathon)
      assert_response :redirect, 'accessed delete path'
    end
  end

  test 'should not create' do
    post marathons_path, marathon: { name: 'a' }
    assert_response :success
    assert_select '.errors'
  end

  test 'should create' do
    get new_marathon_path
    assert_response :success
    post marathons_path, marathon: { name: 'new one' }
    assert_response :redirect
    follow_redirect!
    assert_select '.alert-success'
  end

  test 'should see buttons' do
    count = Marathon.count
    get marathons_path
    assert_select '.glyphicon-search', count
    assert_select '.glyphicon-trash', count
  end

  test 'should not see buttons' do
    logout
    log_in_as(users(:simple))
    get marathons_path
    assert_select '.glyphicon-search', 1
    assert_select '.glyphicon-trash', 0
  end

  test 'should delete' do
    assert_no_difference 'Marathon.with_deleted.count' do
      assert_difference 'Marathon.count', -1 do
        delete marathon_path(marathons(:one))
      end
    end
  end
end
