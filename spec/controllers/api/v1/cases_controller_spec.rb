require 'spec_helper'
require 'oauth'

API_ENDPOINT = 'https://krizinc.desk.com'

describe Api::V1::CasesController do
  describe 'GET index' do
    context 'with filter ID' do
      it 'returns cases filtered by filter ID' do
        OAuth::AccessToken.any_instance.should_receive(:get).with("#{API_ENDPOINT}/api/v2/filters/123/cases")
        get :index, filter_id: 123
      end
    end

    context 'without filter ID' do
      it 'returns all cases' do
        OAuth::AccessToken.any_instance.should_receive(:get).with("#{API_ENDPOINT}/api/v2/cases")
        get :index
      end
    end
  end
end