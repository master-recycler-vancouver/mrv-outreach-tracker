# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def show?
    # any logged in user should be able to see other students
    true
  end

  def update?
    record == user
  end

  def profile?
    # this is like show but for the user's own page
    update?
  end
end
