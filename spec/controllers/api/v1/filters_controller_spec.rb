require 'spec_helper'
require 'oauth'

API_ENDPOINT = 'https://krizinc.desk.com'
FILTERS_JSON = {
    embedded: { entries: { name: 'My Filter'}}
}

describe Api::V1::FiltersController do
  describe 'GET index' do
    it 'returns all filters' do
      Desk::Filter.should_receive(:list)
      Desk::Filter.stub(:list).and_return(FILTERS_JSON)

      get :index
      response.body.should eq(FILTERS_JSON.to_json)
    end
  end
end