module Api
  module V1
    class LabelsController < ApiController
      respond_to :json

      def index
        response = @access_token.get("#{API_ENDPOINT}/api/v2/labels")

        return head :error if response.nil?

        labels = JSON.parse(response.body)
        render json: labels
      end

      def create
        body = {
            name: params[:label][:name]
        }

        response = @access_token.post(
            "#{API_ENDPOINT}/api/v2/labels",
            body.to_json,
            { 'Accept' => 'application/json', 'Content-Type' => 'application/json' })

        head :ok
      end
    end
  end
end
