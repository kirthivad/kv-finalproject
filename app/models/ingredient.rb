class Ingredient < ApplicationRecord
  # Direct associations

  has_many   :meal_options,
             :dependent => :destroy

  # Indirect associations

  # Validations

end
