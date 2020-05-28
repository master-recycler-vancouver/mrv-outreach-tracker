class UserPolicy < ApplicationPolicy

  def show?
    # any logged in user should be able to see other students
    true
  end

  def update?
    record == user
  end

  def to_csv?
    user.admin? or user.facilitator?
  end

end
