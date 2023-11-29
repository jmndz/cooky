# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

User.create(
  name: "Admin", 
  email: "admin@admin.com", 
  password: "Asd@123!", 
  password_confirmation: "Asd@123!", 
  admin: true,
  agreed_to_terms_and_conditions: true,
  agreed_to_privacy_and_policy: true
)

35.times do |i|
  user = User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: "Asd@123!",
    password_confirmation: "Asd@123!",
    admin: false,
    agreed_to_terms_and_conditions: true,
    agreed_to_privacy_and_policy: true
  )

  recipe = Recipe.new(
            name: Faker::Food.dish,
            number_of_servings: rand(1..10),
            preparation_time: "#{rand(1..23)}:#{rand(1..59)}",
            user: user,
            ingredients: Faker::Markdown.unordered_list,
            procedure: Faker::Markdown.ordered_list,
          )
  recipe.image.attach(
    io: File.open(File.join(Rails.root,'app/assets/images/sign_in/desktop_bg.png')),
    filename: 'desktop_bg.png'
  )
  recipe.save
end