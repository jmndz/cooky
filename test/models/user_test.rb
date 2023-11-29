require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      name: "Test User",
      email: "test@test.com",
      password: "password",
      password_confirmation: "password",
      agreed_to_terms_and_conditions: true,
      agreed_to_privacy_and_policy: true
    )
    @image = (Rack::Test::UploadedFile.new("test/fixtures/files/test.png", "image/png"))
  end

  test "should have a name" do
    @user.name = nil
    assert_not @user.valid?
  end

  test "should have an email" do
    @user.email = nil
    assert_not @user.valid?
  end

  test "should have a minimum password length of 8" do
    @user.password = "123"
    assert_not @user.valid?
  end

  test "should have agreed to terms and conditions" do
    @user.agreed_to_terms_and_conditions = false
    assert_not @user.valid?
  end

  test "should have agreed to privacy and policy" do
    @user.agreed_to_privacy_and_policy = false
    assert_not @user.valid?
  end

  test "should save user with all the required attributes" do
    assert_difference("User.count", 1) do
      @user.save
    end
  end

  test "should destroy associated recipes when user is destroyed" do
    @user.save
    @user.recipes.create(
      name: "Test Recipe", 
      number_of_servings: 4, 
      preparation_time: "1:30", 
      ingredients: "Test ingredients", 
      procedure: "Test procedure",
      image: @image    
    )
    assert_difference('Recipe.count', -1) do
      @user.destroy
    end
  end
end
