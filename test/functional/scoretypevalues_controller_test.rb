require 'test_helper'

class ScoretypevaluesControllerTest < ActionController::TestCase
  setup do
    @scoretypevalue = scoretypevalues(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:scoretypevalues)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create scoretypevalue" do
    assert_difference('Scoretypevalue.count') do
      post :create, scoretypevalue: { value: @scoretypevalue.value }
    end

    assert_redirected_to scoretypevalue_path(assigns(:scoretypevalue))
  end

  test "should show scoretypevalue" do
    get :show, id: @scoretypevalue
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @scoretypevalue
    assert_response :success
  end

  test "should update scoretypevalue" do
    put :update, id: @scoretypevalue, scoretypevalue: { value: @scoretypevalue.value }
    assert_redirected_to scoretypevalue_path(assigns(:scoretypevalue))
  end

  test "should destroy scoretypevalue" do
    assert_difference('Scoretypevalue.count', -1) do
      delete :destroy, id: @scoretypevalue
    end

    assert_redirected_to scoretypevalues_path
  end
end
