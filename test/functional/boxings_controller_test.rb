require 'test_helper'

class BoxingsControllerTest < ActionController::TestCase
  setup do
    @boxing = boxings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:boxings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create boxing" do
    assert_difference('Boxing.count') do
      post :create, boxing: {  }
    end

    assert_redirected_to boxing_path(assigns(:boxing))
  end

  test "should show boxing" do
    get :show, id: @boxing
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @boxing
    assert_response :success
  end

  test "should update boxing" do
    put :update, id: @boxing, boxing: {  }
    assert_redirected_to boxing_path(assigns(:boxing))
  end

  test "should destroy boxing" do
    assert_difference('Boxing.count', -1) do
      delete :destroy, id: @boxing
    end

    assert_redirected_to boxings_path
  end
end
