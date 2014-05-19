require 'desk/desk'

module Desk
  class Label
    class << self
      def list
        response = Desk.access_token.get("#{Desk.site}/api/v2/labels")

        Desk.raise_error(response.body) unless response.code.to_i == 200

        JSON.parse(response.body)
      end

      def create(name)
        body = {
            name: name
        }

        response = Desk.access_token.post(
            "#{Desk.site}/api/v2/labels",
            body.to_json,
            { 'Accept' => 'application/json', 'Content-Type' => 'application/json' })

        Desk.raise_error(response.body) unless response.code.to_i == 201

        JSON.parse(response.body)
      end
    end
  end
end