# frozen_string_literal: true

class SubscriberPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user.present?
  end

  def destroy?
    user.author_of?(record)
  end
end
