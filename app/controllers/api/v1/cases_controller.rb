class Api::V1::CasesController < ApiController
  respond_to :json

  def index
    response = @access_token.get("#{API_ENDPOINT}/api/v2/cases")
    cases = JSON.parse(response.body)
    render json: cases
  end
end