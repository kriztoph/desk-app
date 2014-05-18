class ApiController < ActionController::Base
  API_ENDPOINT = 'https://krizinc.desk.com'
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_filter :desk_auth

  private

  def desk_auth
    consumer = OAuth::Consumer.new(
        'f3VhljkR9R51UW7bzPHx',
        'DLYPEekjTBJp2Ok2oqP8ZDTKbUsTultzVefcuWba',
        site: "https://krizinc.desk.com",
        scheme: :header
    )

    @access_token = OAuth::AccessToken.from_hash(
        consumer,
        oauth_token: 'YUEwGDZWDNWr6lwXr4Ok',
        oauth_token_secret: 'TxLmbOJ9aHHYGyYWP4F9ISpvBz5YzzW8AsbfSRs3'
    )
  end
end
