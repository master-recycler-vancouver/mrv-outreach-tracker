class UserPolicy < ApplicationPolicy

  def profile?
    record == user
  end

  def show?
    true
  end

end
