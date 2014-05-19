module Api
  module V1
    class FiltersController < ApiController
      respond_to :json

      def index
        filters = Desk::Filter.list

        return head :error if filters.nil?

        render json: filters
      end
    end
  end
end
