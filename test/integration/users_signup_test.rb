require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup submission" do
    get signup_path
    assert_select 'form[action="/signup"]'
    assert_no_difference 'User.count' do
      post users_path, params: { user: {name: "",
                                 email: "user@invalid",
                                 password: "monkey",
                                 password_confirmation: "turtle" } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end
end
