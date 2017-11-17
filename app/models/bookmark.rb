class Bookmark < ApplicationRecord
  # Direct associations

  belongs_to :recipe

  belongs_to :user

  # Indirect associations

  # Validations

end
