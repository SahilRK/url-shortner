require 'test_helper'

class ShortUrlTest < ActiveSupport::TestCase
  def setup
    @valid_user = User.new(uname: "url-test-user", email: "usl-user@email.com", password: "url-user")

    @short_url = ShortUrl.new(original_url: "www.google.com/test123", shorty: "err12", visit_counts: " ", user_id: "#{@valid_user.id}")
  end

  test "uniqueness of original url" do
    short_url_dup = @short_url.dup
    @short_url.save
    short_url_dup.save
    assert_equal "has already been taken",short_url_dup.errors[:original_url].first
  end

  test "generate unique short url" do
    @short_url_sec = ShortUrl.new(original_url: "www.google.com/test1234", visit_counts: " ", user_id: "#{@valid_user.id}")
    @short_url.save
    @short_url_sec.generate_short_url
    @short_url_sec.save
    assert_not_equal @short_url.shorty, @short_url_sec.shorty
  end
end
