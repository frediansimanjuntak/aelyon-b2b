module Spree
  module Admin
    class JobDescriptionsController < ResourceController
      before_action :load_data

      private

      def load_data
        @available_departments = Department.order(:name)
      end
    end
  end
end
