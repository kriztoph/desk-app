require 'desk/desk'

module Desk
  class Label
    class << self
      def list
        response = Desk.access_token.get("#{Desk.site}/api/v2/labels")
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

        response
      end
    end
  end
end