# frozen_string_literal: true

class QuestionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def new?
    create?
  end

  def create?
    user.present?
  end

  def update?
    user.admin? || user == record.user
  end

  def destroy?
    user.admin? || user == record.user
  end

  def best?
    user == record.user
  end
end
