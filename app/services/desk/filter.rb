require 'desk/desk'

module Desk
  class Filter
    class << self
      def list
        labels_response = Desk.access_token.get("#{Desk.site}/api/v2/filters")
        JSON.parse(labels_response.body)
      end
    end
  end
end