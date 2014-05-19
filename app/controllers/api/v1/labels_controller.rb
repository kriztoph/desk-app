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
        response = Desk::Label.create(params[:label][:name])
        head :ok
      end
    end
  end
end
