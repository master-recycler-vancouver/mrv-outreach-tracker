class UserPolicy < ApplicationPolicy

  def show?
    record == user
  end

  def update?
    record == user
  end

  def show?
    true
  end

end
