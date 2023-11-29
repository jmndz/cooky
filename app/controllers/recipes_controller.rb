class RecipesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  before_action :user_restriction, only: [:edit, :update, :destroy]

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params.merge(user: current_user))

    if @recipe.save
      redirect_to recipe_path(@recipe)
    else
      redirect_back fallback_location: new_recipe_path
    end
  end

  def index
    @own_recipes_pagy, @own_recipes = 
      pagy(
        current_user.recipes, 
        items: 16, 
        page_param: :own_recipes_page, 
        params: { active_tab: "own_recipes" }
      )
    @others_recipes_pagy, @others_recipes = 
      pagy(
        Recipe.where.not(user: current_user), 
        items: 16, 
        page_param: :others_recipes_page, 
        params: { active_tab: "others_recipes" }
      )
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
    @recipe = Recipe.find_by_slug(params[:id])
  end

  def user_restriction
    if @recipe.user != current_user && !current_user.admin?
      redirect_to recipe_path(@recipe)
    end
  end

  def recipe_params
    params.require(:recipe)
      .permit(
        :name,
        :number_of_servings,
        :preparation_time,
        :ingredients,
        :procedure,
        :image
      )
  end
end
