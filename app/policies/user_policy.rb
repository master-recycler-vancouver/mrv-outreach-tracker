class UserPolicy < ApplicationPolicy

  def show?
    # any logged in user should be able to see other students
    true
  end

  def update?
    record == user
  end

end
