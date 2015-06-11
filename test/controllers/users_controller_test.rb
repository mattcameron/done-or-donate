require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:matt)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new, id: @user
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { email: "testuser@email.com", name: "Test User", password: "password"}
    end

    assert_redirected_to "/users/#{assigns(:user).id}/add-credit-card"
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should convert guest to user" do
    put(:convert_guest_to_user, {
      id: @user,
      user: {
        email: @user.email,
        name: @user.name,
        password: "password"
      },
      user_id: @user
    })
    assert_redirected_to "/users/#{@user.id}/add-credit-card"
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
