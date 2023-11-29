require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:basic)
  end

  test "should redirect user to sign in page if user is not logged in" do
    get home_index_path
    assert_redirected_to new_user_session_path
  end

  test "should redirect user to recipes index page if user is logged in" do
    sign_in @user
    get home_index_path
    assert_redirected_to recipes_path
  end
end
