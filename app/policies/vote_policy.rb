# frozen_string_literal: true

class VotePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def vote?
    user.present? && !user.author_of?(record)
  end

  def cancel_vote?
    user.author_of?(record)
  end
end
