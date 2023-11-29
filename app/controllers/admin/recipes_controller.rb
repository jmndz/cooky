class Admin::RecipesController < ApplicationController
  before_action :authenticate_user!, :user_restriction
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params.merge(user: current_user))

    if @recipe.save
      redirect_to admin_recipe_path(@recipe)
    else
      redirect_back fallback_location: new_admin_recipe_path
    end
  end

  def index
    @pagy, @recipes = pagy(Recipe.all.order(created_at: :desc), items: 10)
  end

  def show
    unless @recipe.present?
      redirect_to admin_recipes_path
    end
  end

  def edit
    unless @recipe.present?
      redirect_to admin_recipes_path
    end
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to admin_recipe_path(@recipe)
    else
      redirect_back fallback_location: edit_admin_recipe_path(@recipe)
    end
  end

  def destroy
    if @recipe.destroy
      redirect_to admin_recipes_path
    else
      redirect_back fallback_location: admin_recipes_path
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find_by_slug(params[:id])
  end

  def user_restriction
    unless current_user.admin?
      redirect_to root_path
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
