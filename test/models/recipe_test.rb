require "test_helper"

class RecipeTest < ActiveSupport::TestCase
  def setup
    @user = users(:basic)
    @image = (Rack::Test::UploadedFile.new("test/fixtures/files/test.png", "image/png"))
    @recipe = 
      Recipe.new(
        name: Faker::Food.dish,
        number_of_servings: rand(1..10),
        preparation_time: "#{rand(1..23)}:#{rand(1..59)}",
        user: @user,
        ingredients: Faker::Markdown.unordered_list,
        procedure: Faker::Markdown.ordered_list,
        image: @image
      )
  end

  test "should have a name" do
    @recipe.name = nil
    assert_not @recipe.valid?
  end

  test "should have number of servings" do
    @recipe.number_of_servings = nil
    assert_not @recipe.valid?
  end

  test "should have preparation time" do
    @recipe.preparation_time = nil
    assert_not @recipe.valid?
  end

  test "should have ingredients" do
    @recipe.ingredients = nil
    assert_not @recipe.valid?
  end

  test "should have procedure" do
    @recipe.ingredients = nil
    assert_not @recipe.valid?
  end

  test "should have image" do
    @recipe.image = nil
    assert_not @recipe.valid?
  end

  test "should not save recipe without the required attributes" do
    assert_difference("Recipe.count", 0) do
      Recipe.create
    end
  end

  test "should save recipe with all the required attributes" do
    assert_difference("Recipe.count", 1) do
      @recipe.save
    end
  end

  test "should generate slug upon creation" do
    @recipe.save
    assert_not_nil @recipe.slug
  end

  test "should destroy attached image when recipe is destroyed" do
    @recipe.save
    assert_difference("ActiveStorage::Attachment.count", -1) do
      @recipe.destroy
    end
  end
end
