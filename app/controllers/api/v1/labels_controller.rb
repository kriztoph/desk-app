module Api
  module V1
    class LabelsController < ApiController
      respond_to :json

      def index
        labels = Desk::Label.list

        return head :error if labels.nil?

        render json: labels
      end

      def create
        name = params[:label][:name]
        return head :bad_request unless name
        response = Desk::Label.create(name)

        head :ok
      end
    end
  end
end
