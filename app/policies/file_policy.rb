# frozen_string_literal: true

class FilePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def destroy?
    user == record.user
  end
end
