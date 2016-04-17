require 'test_helper'

class TwitterRelationshipsControllerTest < ActionController::TestCase
  setup do
    @twitter_relationship = twitter_relationships(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:twitter_relationships)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create twitter_relationship" do
    assert_difference('TwitterRelationship.count') do
      post :create, twitter_relationship: { followed: @twitter_relationship.followed, follower: @twitter_relationship.follower }
    end

    assert_redirected_to twitter_relationship_path(assigns(:twitter_relationship))
  end

  test "should show twitter_relationship" do
    get :show, id: @twitter_relationship
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @twitter_relationship
    assert_response :success
  end

  test "should update twitter_relationship" do
    patch :update, id: @twitter_relationship, twitter_relationship: { followed: @twitter_relationship.followed, follower: @twitter_relationship.follower }
    assert_redirected_to twitter_relationship_path(assigns(:twitter_relationship))
  end

  test "should destroy twitter_relationship" do
    assert_difference('TwitterRelationship.count', -1) do
      delete :destroy, id: @twitter_relationship
    end

    assert_redirected_to twitter_relationships_path
  end
end
