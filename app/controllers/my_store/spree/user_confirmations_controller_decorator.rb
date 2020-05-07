module MyStore
  module Spree
    module UserConfirmationsController
      # GET /resource/confirmation?confirmation_token=abcdef
      def show
        self.resource = resource_class.confirm_by_token(params[:confirmation_token])
        yield resource if block_given?

        if resource.errors.empty?
          resource.is_confirmed = true
          resource.save
          set_flash_message!(:notice, :confirmed)
          respond_with_navigational(resource) do
            redirect_to after_confirmation_path_for(resource_name, resource)
          end
        elsif resource.confirmed?
          set_flash_message(:error, :already_confirmed)
          respond_with_navigational(resource) do
            redirect_to after_confirmation_path_for(resource_name, resource)
          end
        else
          respond_with_navigational(resource.errors, status: :unprocessable_entity) do
            render :new
          end
        end
      end
    end
  end
end

::Spree::UserConfirmationsController.prepend MyStore::Spree::UserConfirmationsController