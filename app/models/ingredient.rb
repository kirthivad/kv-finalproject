class Ingredient < ApplicationRecord
  # Direct associations

  has_many   :meal_options,
             :dependent => :destroy

  # Indirect associations

  has_many   :recipes,
             :through => :meal_options,
             :source => :recipe

  # Validations
  
  validates :ingredient_name, :presence => true, :uniqueness => true

end
