require 'desk/desk_api_error'

module Desk
  mattr_accessor :consumer_key
  mattr_accessor :consumer_secret
  mattr_accessor :oauth_token
  mattr_accessor :oauth_token_secret
  mattr_accessor :site

  def self.access_token
    OAuth::AccessToken.from_hash(
        self.consumer,
        oauth_token: self.oauth_token,
        oauth_token_secret: self.oauth_token_secret
    )
  end

  def self.consumer
    OAuth::Consumer.new(
        self.consumer_key,
        self.consumer_secret,
        site: "https://krizinc.desk.com",
        scheme: :header
    )
  end

  def self.raise_error(response)
    raise Desk::DeskApiError.new(self), "#{JSON.parse(response)}"
  end
end