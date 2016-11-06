require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup submission" do
    get signup_path
    assert_select 'form[action="/signup"]'
    assert_no_difference 'User.count' do
      post users_path, params: { user: { firstName: "",
                                 lastName: "",
                                 email: "user@invalid",
                                 password: "monkey",
                                 password_confirmation: "turtle" } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test "valid signup submission" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { firstName: "FakeUser",
                                 lastName: "HasALastName",
                                 email: "user@valid.true",
                                 password: "monkey",
                                 password_confirmation: "monkey" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_equal 'Welcome to Wildflower!', flash[:success]
    assert is_logged_in?
  end
end
