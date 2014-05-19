require 'spec_helper'
require 'oauth'

API_ENDPOINT = 'https://krizinc.desk.com'
LABELS_JSON = {
    embedded: { entries: { name: 'My Filter'}}
}

describe Api::V1::LabelsController do
  describe 'GET index' do
    it 'returns all labels' do
      Desk::Label.should_receive(:list)
      Desk::Label.stub(:list).and_return(LABELS_JSON)

      get :index
      response.body.should eq(LABELS_JSON.to_json)
    end
  end

  describe 'POST create' do

  end
end