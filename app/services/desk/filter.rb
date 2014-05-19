require 'desk/desk'

module Desk
  class Filter
    class << self
      def list
        labels_response = Desk.access_token.get("#{Desk.site}/api/v2/filters")

        Desk.raise_error(labels_response.body) unless labels_response.code.to_i == 200

        JSON.parse(labels_response.body)
      end
    end
  end
end