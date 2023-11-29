require "test_helper"

class ThemesControllerTest < ActionDispatch::IntegrationTest
  test "should update theme and redirect back to root path if referrer is not present" do
    theme = "dark-mode"

    patch themes_path, params: { theme: theme }, xhr: true

    assert_equal theme, cookies[:theme]
    assert_redirected_to root_path
  end

  test "should update theme and redirect to root path if referrer is not present" do
    theme = "light-mode"

    patch themes_path, params: { theme: theme }, xhr: true

    assert_equal theme, cookies[:theme]
    assert_redirected_to root_path
  end
end
