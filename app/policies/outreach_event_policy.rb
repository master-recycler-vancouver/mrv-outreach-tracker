class OutreachEventPolicy < ApplicationPolicy
  def show?
    user.admin? || 
    (user.student? && record.user == user)
  end

  def create?
    user.student?
  end

  def update?
    user.admin? || (user.student? && record.user == user)
  end

  def destroy?
    user.student? && record.user == user
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user_id: user.id)
      end
    end
  end
  
end