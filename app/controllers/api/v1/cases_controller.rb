module Api
  module V1
    class CasesController < ApiController
      respond_to :json

      def index
        filter_id = params[:filter_id]
        if filter_id
          response = @access_token.get("#{API_ENDPOINT}/api/v2/filters/#{filter_id}/cases")
        else
          response = @access_token.get("#{API_ENDPOINT}/api/v2/cases")
        end

        return head :error if response.nil?

        cases = JSON.parse(response.body)

        render json: cases
      end
    end
  end
end