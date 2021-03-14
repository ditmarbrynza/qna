# frozen_string_literal: true

class LinkPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def destroy?
    user.author_of?(record)
  end
end
