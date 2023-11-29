class Recipe < ApplicationRecord
  # Create slug for recipe
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  # Associations
  belongs_to :user

  # Add rich text field
  has_rich_text :ingredients
  has_rich_text :procedure

  # Add image
  has_one_attached :image, dependent: :destroy

  # Validations
  validates_presence_of :name, :number_of_servings, :preparation_time, :ingredients, :procedure, :image
end
