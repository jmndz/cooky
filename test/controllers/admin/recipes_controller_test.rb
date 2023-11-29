require "test_helper"

class Admin::RecipesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @image = (Rack::Test::UploadedFile.new("test/fixtures/files/test.png", "image/png"))
    @admin = users(:admin)
    @basic = users(:basic)
    @params = {
      name: Faker::Food.dish,
      number_of_servings: rand(1..10),
      preparation_time: "#{rand(1..23)}:#{rand(1..59)}",
      user: @basic,
      ingredients: Faker::Markdown.unordered_list,
      procedure: Faker::Markdown.ordered_list,
      image: @image
    }
    @basic_user_recipe = generate_recipe!(@basic)
    @admin_user_recipe = generate_recipe!(@admin)
    sign_in @admin
  end

  test "should not allow access to basic users" do
    sign_out @admin
    sign_in @basic
    get admin_recipes_path
    assert_redirected_to root_path
  end

  test "should render new" do
    get new_admin_recipe_path
    assert_response :success
  end

  test "should render index" do
    get admin_recipes_path
    assert_response :success
  end

  test "should create recipe" do
    assert_difference("Recipe.count", 1) do
      post admin_recipes_path, params: { recipe: @params }
    end
    assert_redirected_to admin_recipe_path(@admin.recipes.last)
  end

  test "should not create recipe if lacking/invalid input" do
    @params[:name] = nil
    assert_difference("Recipe.count", 0) do
      post admin_recipes_path, params: { recipe: @params }
    end
    assert_redirected_to new_admin_recipe_path
  end

  test "should render show" do
    get admin_recipe_path(@basic_user_recipe)
    assert_response :success
  end

  test "should redirect admin to admin recipe index page if recipe does not exist" do
    get admin_recipe_path("test123")
    assert_redirected_to admin_recipes_path
  end 

  test "should render edit" do
    get edit_admin_recipe_path(@basic_user_recipe)
    assert_response :success
  end

  test "should update recipe attributes" do
    patch admin_recipe_path(@basic_user_recipe), params: { recipe: { name: "Pancit Canton" } }, xhr: true
    assert_redirected_to admin_recipe_path(@basic_user_recipe)
  end

  test "should not update recipe attributes if invalid input" do
    @params["name"] = nil
    patch admin_recipe_path(@basic_user_recipe), params: { recipe: @params }, xhr: true
    assert_redirected_to edit_admin_recipe_path(@basic_user_recipe)
  end

  test "should destroy recipe" do
    assert_difference("Recipe.count", -1) do
      delete admin_recipe_path(@basic_user_recipe), xhr: true
    end
    assert_redirected_to admin_recipes_path
  end

  private

  def generate_recipe!(user)
    image = (Rack::Test::UploadedFile.new("test/fixtures/files/test.png", "image/png"))
    Recipe.create(
        name: Faker::Food.dish,
        number_of_servings: rand(1..10),
        preparation_time: "#{rand(1..23)}:#{rand(1..59)}",
        user: user,
        ingredients: Faker::Markdown.unordered_list,
        procedure: Faker::Markdown.ordered_list,
        image: image
      )
  end
end
