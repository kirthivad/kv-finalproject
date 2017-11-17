class CreateMealOptions < ActiveRecord::Migration
  def change
    create_table :meal_options do |t|
      t.integer :ingredient_id
      t.integer :recipe_id

      t.timestamps

    end
  end
end
