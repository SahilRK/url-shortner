require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @valid_user = User.new(uname: "url-test-user", email: "usl-user@email.com", password: "url-user")

    @user_without_email = User.new(uname: "url-test-user", email: " ", password: "url-user")

    @user_without_pass = User.new(uname: "url-test-user", email: "usl-user@email.com", password: " ")
  end

  #tests valid user
  test "validates valid user" do
    assert @valid_user.valid?
  end

  #tests user email validation
  test "validates presence of email" do
    assert @user_without_email.invalid?
    assert_equal "can't be blank",@user_without_email.errors[:email].first
  end

  #tests user password validation
  test "validates presence of password" do
    assert @user_without_pass.invalid?
    assert_equal "can't be blank",@user_without_pass.errors[:password].first
  end

end
