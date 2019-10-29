class Cohort < ApplicationRecord
  has_many :users, -> { where role: :student }
end