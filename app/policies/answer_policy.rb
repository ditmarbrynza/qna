# frozen_string_literal: true

class AnswerPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user.present?
  end

  def update?
    user.admin? || user.author_of?(record)
  end

  def destroy?
    user.admin? || user.author_of?(record)
  end
end
