require 'desk/desk'

module Api
  module V1
    class CasesController < ApiController
      respond_to :json

      def index
        filter_id = params[:filter_id]
        if filter_id
          cases = Desk::Case.list_by_filter(filter_id)
        else
          cases = Desk::Case.list
        end

        render json: cases
      end

      def update
        new_label = params[:new_label]
        label_ids = params[:label_ids] || []
        case_id = params[:id]

        response = Desk::Case.add_label(case_id, label_ids, new_label)

        head :ok if response.code == 200
      end

      def show
        cse = Desk::Case.get(params[:id])

        return head :error if cse.nil?

        render json: cse
      end
    end
  end
end