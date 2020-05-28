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

  def batch_invite?
    user.admin?
  end

  def review_invites?
    batch_invite?
  end

  def import?
    batch_invite?
  end
end
