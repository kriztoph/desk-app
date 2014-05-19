require 'desk/desk'

class ApiController < ActionController::Base
  API_ENDPOINT = 'https://krizinc.desk.com'
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_filter :configure_desk

  private

  def configure_desk
    Desk.consumer_key = 'f3VhljkR9R51UW7bzPHx'
    Desk.consumer_secret = 'DLYPEekjTBJp2Ok2oqP8ZDTKbUsTultzVefcuWba'
    Desk.oauth_token = 'YUEwGDZWDNWr6lwXr4Ok'
    Desk.oauth_token_secret = 'TxLmbOJ9aHHYGyYWP4F9ISpvBz5YzzW8AsbfSRs3'
    Desk.site = "https://krizinc.desk.com"
  end
end
