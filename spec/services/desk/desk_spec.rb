require 'spec_helper'

describe Desk do
  it 'should be configurable with security credentials' do
    Desk.should respond_to(
      :consumer_key,
      :consumer_secret,
      :oauth_token,
      :oauth_token_secret,
      :access_token,
      :consumer
    )
  end
end