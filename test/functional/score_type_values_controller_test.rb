require 'test_helper'

class ScoreTypeValuesControllerTest < ActionController::TestCase
  setup do
    @score_type_value = score_type_values(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:score_type_values)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create score_type_value" do
    assert_difference('ScoreTypeValue.count') do
      post :create, score_type_value: {  }
    end

    assert_redirected_to score_type_value_path(assigns(:score_type_value))
  end

  test "should show score_type_value" do
    get :show, id: @score_type_value
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @score_type_value
    assert_response :success
  end

  test "should update score_type_value" do
    put :update, id: @score_type_value, score_type_value: {  }
    assert_redirected_to score_type_value_path(assigns(:score_type_value))
  end

  test "should destroy score_type_value" do
    assert_difference('ScoreTypeValue.count', -1) do
      delete :destroy, id: @score_type_value
    end

    assert_redirected_to score_type_values_path
  end
end
