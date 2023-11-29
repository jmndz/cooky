require "test_helper"

class Users::RegistrationsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @params = {
      name: "Test User",
      email: "test@test.com",
      password: "password",
      password_confirmation: "password",
      agreed_to_terms_and_conditions: true,
      agreed_to_privacy_and_policy: true
    }
  end

  test "should render new" do
    get new_user_registration_path
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count', 1) do
      post user_registration_path, params: { user: @params}
    end
    assert_redirected_to recipes_path
  end

  test "should not create user with invalid inputs" do
    @params["name"] = nil
    assert_difference('User.count', 0) do
      post user_registration_path, params: { user: @params}
    end
    assert_redirected_to new_user_registration_path
  end
end
