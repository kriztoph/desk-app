require 'spec_helper'
require 'oauth'

API_ENDPOINT = 'https://krizinc.desk.com'

describe Api::V1::FiltersController do
  describe 'GET index' do
    it 'returns all filters' do
      OAuth::AccessToken.any_instance.should_receive(:get).with("#{API_ENDPOINT}/api/v2/filters")
      get :index
    end
  end
end