require 'test_helper'

class KksControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:kks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create kk" do
    assert_difference('Kk.count') do
      post :create, :kk => { }
    end

    assert_redirected_to kk_path(assigns(:kk))
  end

  test "should show kk" do
    get :show, :id => kks(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => kks(:one).to_param
    assert_response :success
  end

  test "should update kk" do
    put :update, :id => kks(:one).to_param, :kk => { }
    assert_redirected_to kk_path(assigns(:kk))
  end

  test "should destroy kk" do
    assert_difference('Kk.count', -1) do
      delete :destroy, :id => kks(:one).to_param
    end

    assert_redirected_to kks_path
  end
end
