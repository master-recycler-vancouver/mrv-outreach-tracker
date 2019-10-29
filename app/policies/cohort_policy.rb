class CohortPolicy < ApplicationPolicy
  def show?
    user.admin? || user.student?
  end

  def create?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end

  class Scope < Scope
    def resolve
      scope.all if (user.admin? || user.student?)
    end
  end
end