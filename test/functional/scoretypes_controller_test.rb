require 'test_helper'

class ScoretypesControllerTest < ActionController::TestCase
  setup do
    @scoretype = scoretypes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:scoretypes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create scoretype" do
    assert_difference('Scoretype.count') do
      post :create, scoretype: { description: @scoretype.description }
    end

    assert_redirected_to scoretype_path(assigns(:scoretype))
  end

  test "should show scoretype" do
    get :show, id: @scoretype
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @scoretype
    assert_response :success
  end

  test "should update scoretype" do
    put :update, id: @scoretype, scoretype: { description: @scoretype.description }
    assert_redirected_to scoretype_path(assigns(:scoretype))
  end

  test "should destroy scoretype" do
    assert_difference('Scoretype.count', -1) do
      delete :destroy, id: @scoretype
    end

    assert_redirected_to scoretypes_path
  end
end
