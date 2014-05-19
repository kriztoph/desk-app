require 'desk/desk_api_error'

describe Desk::Filter do
  describe '#list' do
    it 'returns all filters' do
      Desk.stub_chain(:access_token, :get).and_return(double('Net::Http', code: 200, body: {a: 1}.to_json))
      Desk::Filter.list.should eq({"a" => 1})
    end

    it 'raises an error if there is an api error' do
      Desk.stub_chain(:access_token, :get).and_return(double('Net::Http', code: 400, body: {message: 'bad request'}.to_json))
      expect { Desk::Filter.list }.to raise_error
    end
  end
end