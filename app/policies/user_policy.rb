# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def show?
    # any logged in user should be able to see other students
    true
  end

  def update?
    record == user
  end

  def show?
    true
  end

end
