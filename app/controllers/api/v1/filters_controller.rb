module Api
  module V1
    class FiltersController < ApiController
      respond_to :json

      def index
        response = @access_token.get("#{API_ENDPOINT}/api/v2/filters")

        return head :error if response.nil?

        filters = JSON.parse(response.body)
        render json: filters
      end
    end
  end
end
