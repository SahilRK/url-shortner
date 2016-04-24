require 'test_helper'

class ShortUrlsControllerTest < ActionController::TestCase
  def valid_user
    @valid_user = User.create(uname: "url-test-user", email: "usl-user@email.com", password: "url-user")
    session[:user_id] = @valid_user.id
  end

  test "should be authenticated user to create short url" do
    get :new
    assert_redirected_to log_in_path
  end

  test "should be able to view url generation form" do
    valid_user
    get :new
    assert_response :success
  end

  test "should be able to create new url" do
    assert_difference('ShortUrl.count') do
      post :create, short_url: {original_url: "www.google.com/test123", shorty: "err12", visit_counts: "0", user_id: "#{valid_user}"}
    end
  end

  test "should be authenticated user to view short urls" do
    get :index
    assert_redirected_to log_in_path
  end

  test "should be able to show short urls" do
    valid_user
    get :index
    assert_response :success
  end

end
