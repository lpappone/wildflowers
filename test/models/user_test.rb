require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(firstName: 'example', lastName: 'exshample', email: 'user@gmail.com')
  end

  test "user should be valid" do
    assert @user.valid?
  end

  test "firstname should be present" do
    @user.firstName = " "
    assert_not @user.valid?
  end

  test "lastname should be present" do
    @user.lastName = " "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "firstName should not be too long" do
    @user.firstName = "a" * 51
    assert_not @user.valid?
  end

  test "lastName should not be too long" do
    @user.lastName = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.co a_us-ER@foo.bar.eu first.last@foo.jp alice+bob@eve.cn]
    valid_addresses.each do |address|
      @user.email = address
      assert @user.valid? "#{address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[foo@bar..com user@example,com user_foo.org user@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |address|
      @user.email = address
      assert_not @user.valid?, "#{address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
end
