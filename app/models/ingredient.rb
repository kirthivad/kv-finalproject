class Ingredient < ApplicationRecord
  # Direct associations

  belongs_to :user

  has_many   :meal_options,
             :dependent => :destroy

  # Indirect associations

  # Validations

end
