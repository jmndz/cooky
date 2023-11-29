require "test_helper"

class Users::SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:basic)
  end

  test "should render new template" do
    get new_user_session_path
    assert_response :success
    assert assigns(:user).new_record?
  end

  test "should redirect to recipes path if authentication is successful" do
    post user_session_path, params: { user: { email: "basic@basic.com", password: "Asd@123!" } }
    assert_redirected_to recipes_path
  end

  test "should redirect to new_user_session_path if authentication is unsuccessful" do
    post user_session_path, params: { user: { email: "basic@basic.com", password: "invalid" } }
    assert_redirected_to new_user_session_path
  end

  test "should sign out" do
    sign_in @user
    delete '/users/sign_out'
    assert_redirected_to root_path
  end
end
