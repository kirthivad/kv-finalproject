class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :food_group
      t.text :ingredients
      t.text :instructions

      t.timestamps

    end
  end
end
