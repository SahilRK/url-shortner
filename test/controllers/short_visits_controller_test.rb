require 'test_helper'

class ShortVisitsControllerTest < ActionController::TestCase
  def valid_user
    @valid_user = User.create(uname: "url-test-user", email: "usl-user@email.com", password: "url-user")
    session[:user_id] = @valid_user.id
  end

  def short_url
    @short_url = ShortUrl.create(original_url: "www.google.com/test123", shorty: "err12", visit_counts: "0", user_id: "#{@valid_user.id}")
  end

  test "should validate presence of short url" do
    @valid_user = User.create(uname: "url-test-user", email: "usl-user@email.com", password: "url-user")
    @short_url = ShortUrl.create(original_url: "www.google.com/test123", shorty: "err12", visit_counts: "0", user_id: "#{@valid_user.id}")
    get :short_original_url, short_url_id: @short_url.shorty
    shorty = ShortUrl.search_shorty(@short_url.shorty)

    assert_equal 1,shorty.count
  end

  test "should create short visit for short url" do
    @valid_user = User.create(uname: "url-test-user", email: "usl-user@email.com", password: "url-user")
    @short_url = ShortUrl.create(original_url: "www.google.com/test123", shorty: "err12", visit_counts: "0", user_id: "#{@valid_user.id}")
    get :short_original_url, short_url_id: @short_url.shorty
    shorty = ShortUrl.search_shorty(@short_url.shorty)

    short_visit = ShortVisit.create(visitor_ip: request.remote_ip, short_url_id: shorty.first.id)

    assert_equal 1,ShortVisit.count
  end
end
