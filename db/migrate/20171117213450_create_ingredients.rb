class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.integer :user_id
      t.string :food_group

      t.timestamps

    end
  end
end
