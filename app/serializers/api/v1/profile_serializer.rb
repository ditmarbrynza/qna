# frozen_string_literal: true

module Api
  module V1
    class ProfileSerializer < ActiveModel::Serializer
      attributes %i[id email admin created_at updated_at]
    end
  end
end
