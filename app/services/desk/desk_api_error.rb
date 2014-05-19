module Desk
  class DeskApiError < StandardError
    attr_reader :resource

    def initialize(resource)
      @resource = resource
    end
  end
end
