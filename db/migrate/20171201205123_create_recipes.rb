class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :recipe_name
      t.text :ingredient_list
      t.text :instructions
      t.string :recipe_type

      t.timestamps

    end
  end
end
