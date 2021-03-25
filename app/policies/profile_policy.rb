# frozen_string_literal: true

class ProfilePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def me?
    user.present?
  end

  def all?
    user.admin?
  end
end
