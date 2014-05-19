require 'desk/desk_api_error'

describe Desk::Label do
  describe '#list' do
    it 'returns all labels' do
      Desk.stub_chain(:access_token, :get).and_return(double('Net::Http', code: 200, body: {a: 1}.to_json))
      Desk::Label.list.should eq({"a" => 1})
    end

    it 'raises an error if there is an api error' do
      Desk.stub_chain(:access_token, :get).and_return(double('Net::Http', code: 400, body: {message: 'bad request'}.to_json))
      expect { Desk::Label.list }.to raise_error
    end
  end

  describe '#create' do
    it 'creates a new label' do
      Desk.stub_chain(:access_token, :post).and_return(double('Net::Http', code: 201, body: {a: 1}.to_json))
      expect { Desk::Label.create('cool label') }.to_not raise_error
    end
  end
end
