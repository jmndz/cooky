class RecipesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)

    # Redirect user to recipe#show page if recipe creation is successful, otherwise, redirect back to new recipe page
    if @recipe.save
      redirect_to recipe_path(@recipe)
    else
      redirect_back fallback_location: new_recipe_path
    end
  end

  def index
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_recipe
    @recipe = Recipe.find_by_id(params[:id])
  end

  def recipe_params
    params.require(:recipe)
      .permit(
        :name,
        :number_of_servings,
        :preparation_time,
        :ingredients,
        :procedure,
        :recipe_image
      ).merge(
        user: current_user
      )
  end
end
