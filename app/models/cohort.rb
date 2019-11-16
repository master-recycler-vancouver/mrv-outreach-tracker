class Cohort < ApplicationRecord
  has_many :users, -> { where role: :student }
  before_destroy :check_can_be_destroyed

  private

    def check_can_be_destroyed
      return if users.count == 0
      errors.add :base, "Cannot delete a cohort that has students"
      throw(:abort)
    end
end