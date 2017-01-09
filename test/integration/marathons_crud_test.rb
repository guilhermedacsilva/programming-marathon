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

  test 'should load one line table index' do
    assert Marathon.count > 1
    my_marathon = marathons(:one)
    get marathons_path
    assert_response :success
    assert_select 'tr', 2
    assert_select 'tr td:nth-child(2)', my_marathon.name
  end

  test 'should not access' do
    logout
    log_in_as(users(:simple))
    marathon = Marathon.first
    assert_no_difference 'Marathon.count' do
      get new_marathon_path
      assert_response :redirect, 'accessed new path'
      get edit_marathon_path(marathon.id)
      assert_response :redirect, 'accessed edit path'
      post marathons_path
      assert_response :redirect, 'accessed post path'
      patch marathon_path(marathon.id)
      assert_response :redirect, 'accessed patch path'
      delete marathon_path(marathon.id)
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
end
