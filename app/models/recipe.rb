class Recipe < ApplicationRecord
  # Direct associations

  belongs_to :user

  has_many   :bookmarks,
             :dependent => :destroy

  has_many   :meal_options,
             :dependent => :destroy

  # Indirect associations

  has_many   :fans,
             :through => :bookmarks,
             :source => :user

  has_many   :ingredients,
             :through => :meal_options,
             :source => :ingredient

  # Validations
  
  validates :recipe_name, :presence => true, :uniqueness => true
  validates :recipe_type, :presence => true
  validates :instructions, :presence => true
  validates :ingredient_list, :presence => true

end
