class Recipe < ApplicationRecord
  # Direct associations

  has_many   :bookmarks,
             :dependent => :destroy

  has_many   :meal_options,
             :dependent => :destroy

  # Indirect associations

  has_many   :ingredients,
             :through => :meal_options,
             :source => :ingredient

  # Validations

end
