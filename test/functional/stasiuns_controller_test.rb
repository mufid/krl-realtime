require 'test_helper'

class StasiunsControllerTest < ActionController::TestCase
  setup do
    @stasiun = stasiuns(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stasiuns)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stasiun" do
    assert_difference('Stasiun.count') do
      post :create, stasiun: { kode: @stasiun.kode }
    end

    assert_redirected_to stasiun_path(assigns(:stasiun))
  end

  test "should show stasiun" do
    get :show, id: @stasiun
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stasiun
    assert_response :success
  end

  test "should update stasiun" do
    put :update, id: @stasiun, stasiun: { kode: @stasiun.kode }
    assert_redirected_to stasiun_path(assigns(:stasiun))
  end

  test "should destroy stasiun" do
    assert_difference('Stasiun.count', -1) do
      delete :destroy, id: @stasiun
    end

    assert_redirected_to stasiuns_path
  end
end
