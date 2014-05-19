require 'desk/desk'
require 'oauth/request_proxy/typhoeus_request'

module Desk
  class Case
    class << self
      def list
        response = Desk.access_token.get("#{Desk.site}/api/v2/cases")
        JSON.parse(response.body)
      end

      def list_by_filter(filter_id)
        response = Desk.access_token.get("#{Desk.site}/api/v2/filters/#{filter_id}/cases")
        JSON.parse(response.body)
      end

      def add_label(case_id, label_ids, new_label)
        labels = Desk::Label.list

        name = labels['embedded']['entries'].select do |label|
          label['name'] == new_label
        end

        body = {
            name: new_label
        }

        response = Desk.access_token.post(
            "#{Desk.site}/api/v2/labels",
            body.to_json,
            { 'Accept' => 'application/json', 'Content-Type' => 'application/json' })

        label_id = JSON.parse(response.body)['id']
        label_ids.push(label_id)

        oauth_params = {:consumer => Desk.consumer, :token => Desk.access_token}
        hydra = Typhoeus::Hydra.new
        req = Typhoeus::Request.new(
            "#{Desk.site}/api/v2/cases/#{case_id}",
            method: :patch,
            body: {labels: [new_label]}.to_json
        )
        oauth_helper = OAuth::Client::Helper.new(req, oauth_params.merge(:request_uri => "#{Desk.site}/api/v2/cases/#{case_id}"))
        req.options[:headers].merge!({"Authorization" => oauth_helper.header}) # Signs the request
        hydra.queue(req)
        hydra.run

        req.response
      end

      def get(id)
        response = Desk.access_token.get("#{Desk.site}/api/v2/cases/#{id}")
        JSON.parse(response.body)
      end

      def update

      end
    end
  end
end