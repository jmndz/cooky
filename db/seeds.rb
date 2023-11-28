# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.create(
  name: "Admin", 
  email: "admin@admin.com", 
  password: "Asd@123!", 
  password_confirmation: "Asd@123!", 
  admin: true,
  agreed_to_terms_and_conditions: true,
  agreed_to_privacy_and_policy: true
)