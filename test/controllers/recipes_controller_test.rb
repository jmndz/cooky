require "test_helper"

class RecipesControllerTest < ActionDispatch::IntegrationTest
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
    sign_in @basic
    @basic_user_recipe = generate_recipe!(@basic)
    @admin_user_recipe = generate_recipe!(@admin)
  end

  test "should render new" do
    get new_recipe_path
    assert_response :success
  end

  test "should render index" do
    get recipes_path
    assert_response :success
  end

  test "should create recipe" do
    assert_difference("Recipe.count", 1) do
      post recipes_path, params: { recipe: @params }
    end
    assert_redirected_to recipe_path(@basic.recipes.last)
  end

  test "should not create recipe if lacking/invalid input" do
    @params[:name] = nil
    assert_difference("Recipe.count", 0) do
      post recipes_path, params: { recipe: @params }
    end
    assert_redirected_to new_recipe_path
  end

  test "should render show" do
    get recipe_path(@basic_user_recipe)
    assert_response :success
  end

  test "should redirect user to recipe index page if recipe does not exist" do
    get recipe_path("test123")
    assert_redirected_to recipes_path
  end 

  test "should render edit" do
    get edit_recipe_path(@basic_user_recipe)
    assert_response :success
  end

  test "should only allow author or admin to edit selected recipe" do
    get edit_recipe_path(@admin_user_recipe)
    assert_redirected_to recipe_path(@admin_user_recipe)
  end

  test "should update recipe attributes" do
    patch recipe_path(@basic_user_recipe), params: { recipe: @params }, xhr: true
    assert JSON(response.body).fetch("success")
  end

  test "should not update recipe attributes if invalid input" do
    @params["name"] = nil
    patch recipe_path(@basic_user_recipe), params: { recipe: @params }, xhr: true
    assert_not JSON(response.body).fetch("success")
  end

  test "should destroy recipe" do
    assert_difference("Recipe.count", -1) do
      delete recipe_path(@basic_user_recipe), xhr: true
    end
    assert_equal response.body, ({ success: true }).to_json
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
