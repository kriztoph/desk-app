class Api::V1::FiltersController < ApiController
  respond_to :json

  def index
    response = @access_token.get("#{API_ENDPOINT}/api/v2/filters")
    filters = JSON.parse(response.body)
    render json: filters
  end
end