class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.string :name
      t.integer :number_of_servings
      t.string :preparation_time
      t.belongs_to :user, foreign_key: true
      t.timestamps
    end
  end
end
