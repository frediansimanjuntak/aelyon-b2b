module MyStore
  module Spree
    module UserRegistrationsControllerDecorator
      # POST /resource/sign_up
      def create
        # render json: params.to_json 
        @user = build_resource(spree_user_params)
        resource_saved = resource.save
        if (params[:form_type] == "company")
          # Create vendor
          create_vendor
        end
        yield resource if block_given?
        if resource_saved
          if resource.active_for_authentication?
            set_flash_message :notice, :signed_up
            sign_up(resource_name, resource)
            session[:spree_user_signup] = true
            redirect_to_checkout_or_account_path(resource)
          else
            set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}"
            expire_data_after_sign_in!
            respond_with resource, location: after_inactive_sign_up_path_for(resource)
          end
        else
          clean_up_passwords(resource)
          if (params[:form_type] == "company")
            render :new_user_company
          elsif (params[:form_type] == "personal")
            render :new_user_personal
          else
            render :new
          end
        end
      end

      def new_user_company
        build_resource({})
        respond_with self.resource
      end

      def create_user_company
        
      end

      def new_user_personal
        build_resource({})
        respond_with self.resource
      end

      def create_user_personal
        
      end

      private
      def create_vendor
        vendor = ::Spree::Vendor.create(name: params[:company_name])
        vendor_detail = ::Spree::VendorDetail.create({
          name: params[:company_name],
          business_identity: [{type: params[:company_identity_type], number: params[:company_identity_number]}],
          vendor_id: vendor.id
        })
        vendor_user = ::Spree::VendorUser.create({user_id: resource.id, vendor_id: vendor.id})
      end
    end
  end
end


::Spree::UserRegistrationsController.prepend MyStore::Spree::UserRegistrationsControllerDecorator if ::Spree::UserRegistrationsController.included_modules.exclude?(MyStore::Spree::UserRegistrationsControllerDecorator)
