class Recipe < ApplicationRecord
  # Associations
  belongs_to :user

  # Add rich text field
  has_rich_text :ingredients
  has_rich_text :procedure

  # Add image
  has_one_attached :recipe_image, dependent: :destroy

  # Validations
  validates_presence_of :name, :number_of_servings, :preparation_time, :ingredients, :procedure, :recipe_image
end
