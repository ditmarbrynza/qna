# frozen_string_literal: true

module Api
  module V1
    class ProfilesController < Api::V1::BaseController
      def me
        render json: current_resource_owner
      end

      def all
        @profiles = User.where("id != #{current_resource_owner.id}")
        render json: @profiles, each_serializer: ::Api::V1::ProfileSerializer
      end
    end
  end
end
