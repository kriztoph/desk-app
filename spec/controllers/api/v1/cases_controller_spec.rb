require 'spec_helper'
require 'oauth'

API_ENDPOINT = 'https://krizinc.desk.com'
CASES_JSON = {'_embedded' => { entries: [
    {id: 1, subject: 'Case Subject'},
    {id: 2, subject: 'Case Subject 2'},
]}}

CASE_JSON = {id: 1, subject: 'Case Subject'}

describe Api::V1::CasesController do
  describe 'GET index' do
    context 'with filter ID' do
      it 'returns cases filtered by filter ID' do
        Desk::Case.stub(:list_by_filter).and_return(CASES_JSON)
        Desk::Case.should_receive(:list_by_filter).with('123')

        get :index, filter_id: 123

        response.body.should eq(CASES_JSON.to_json)
      end
    end

    context 'without filter ID' do
      it 'returns all cases' do
        Desk::Case.stub(:list).and_return(CASES_JSON)
        Desk::Case.should_receive(:list)

        get :index

        response.body.should eq(CASES_JSON.to_json)
      end
    end
  end

  describe 'GET show' do
    it 'returns case by id' do
      Desk::Case.stub(:get).and_return(CASE_JSON)
      Desk::Case.should_receive(:get).with('12')

      get :show, id: 12

      response.body.should eq(CASE_JSON.to_json)
    end
  end

  describe 'PUT update' do
    it 'updates the case with a new label' do
      Desk::Case.should_receive(:add_label).with('12', ['1','2','3'], 'cool label')
      Desk::Case.stub(:add_label).and_return(double('Net:HTTP', code: 200))
      put :update, new_label: 'cool label', label_ids: [1,2,3], id: 12
    end
  end
end