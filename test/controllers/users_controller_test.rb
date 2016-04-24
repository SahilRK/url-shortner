require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  #tests valid user creation
  test "should create user" do
    assert_difference('User.count') do
      post :create, user: {uname: "url-test-user", email: "usl-user@email.com", password: "url-user"}
    end

    assert_redirected_to log_in_path
  end

  #tests invalid user
  test "should not create user" do
    assert_no_difference('User.count') do
      post :create, user: {uname: "url-test-user", email: " ", password: " "}
    end

    assert_template :new
  end

  test "should get index" do
    get :index
    assert_response :success
  end

end
