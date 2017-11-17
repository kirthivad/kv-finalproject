class MealOption < ApplicationRecord
  # Direct associations

  belongs_to :recipe

  belongs_to :ingredient

  # Indirect associations

  # Validations

end
