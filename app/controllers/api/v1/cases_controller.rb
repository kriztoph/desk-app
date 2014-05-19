require 'oauth/request_proxy/typhoeus_request'

module Api
  module V1
    class CasesController < ApiController
      respond_to :json

      def index
        filter_id = params[:filter_id]
        if filter_id
          response = @access_token.get("#{API_ENDPOINT}/api/v2/filters/#{filter_id}/cases")
        else
          response = @access_token.get("#{API_ENDPOINT}/api/v2/cases")
        end

        return head :error if response.nil?

        cases = JSON.parse(response.body)

        render json: cases
      end

      def update
        new_label = params[:new_label]
        label_ids = params[:label_ids]
        labels_response = @access_token.get("#{API_ENDPOINT}/api/v2/labels")
        labels = JSON.parse(labels_response.body.gsub('_embedded', 'embedded'))

        name = labels['embedded']['entries'].select do |label|
          label['name'] == new_label
        end

        body = {
            name: new_label
        }

        response = @access_token.post(
            "#{API_ENDPOINT}/api/v2/labels",
            body.to_json,
            { 'Accept' => 'application/json', 'Content-Type' => 'application/json' })

        label_id = JSON.parse(response.body)['id']
        label_ids.push(label_id)

        oauth_params = {:consumer => @consumer, :token => @access_token}
        hydra = Typhoeus::Hydra.new
        req = Typhoeus::Request.new(
            "#{API_ENDPOINT}/api/v2/cases/#{params[:id]}",
            method: :patch,
            body: {labels: [new_label]}.to_json
        )
        oauth_helper = OAuth::Client::Helper.new(req, oauth_params.merge(:request_uri => "#{API_ENDPOINT}/api/v2/cases/#{params[:id]}"))
        req.options[:headers].merge!({"Authorization" => oauth_helper.header}) # Signs the request
        hydra.queue(req)
        hydra.run

        head :ok if req.response.code == 200
      end

      def show
        response = @access_token.get("#{API_ENDPOINT}/api/v2/cases/#{params[:id]}")
        return head :error if response.nil?

        c = JSON.parse(response.body)

        render json: c
      end
    end
  end
end