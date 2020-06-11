module MyStore
  module Spree
    module Admin
      module TaxonsControllerDecorator
        def update
          successful = @taxon.transaction do
            parent_id = params[:taxon][:parent_id]
            set_position
            set_parent(parent_id)
  
            @taxon.save!
  
            # regenerate permalink
            regenerate_permalink if parent_id
  
            set_permalink_params
  
            # check if we need to rename child taxons if parent name or permalink changes
            @update_children = true if params[:taxon][:name] != @taxon.name || params[:taxon][:permalink] != @taxon.permalink
  
            @taxon.create_icon(attachment: taxon_params[:icon]) if taxon_params[:icon]
            @taxon.create_header_image(attachment: taxon_params[:header_image]) if taxon_params[:header_image]
            @taxon.create_banner(attachment: taxon_params[:banner]) if taxon_params[:banner]
            @taxon.update_attributes(taxon_params.except(:icon, :header_image, :banner))
          end
          if successful
            flash[:success] = flash_message_for(@taxon, :successfully_updated)
  
            # rename child taxons
            rename_child_taxons if @update_children
  
            respond_with(@taxon) do |format|
              format.html { redirect_to edit_admin_taxonomy_url(@taxonomy) }
              format.json { render json: @taxon.to_json }
            end
          else
            respond_with(@taxon) do |format|
              format.html { render :edit }
              format.json { render json: @taxon.errors.full_messages.to_sentence, status: 422 }
            end
          end
        end

        private

        def taxon_params
          params.require(:taxon).permit(:name, :permalink, :description, :icon, :header_image, :banner, :meta_title, :meta_description, :meta_keywords, :hide_from_nav)
        end
      end
    end
  end
end
  
  ::Spree::Admin::TaxonsController.prepend MyStore::Spree::Admin::TaxonsControllerDecorator if ::Spree::Admin::TaxonsController.included_modules.exclude?(MyStore::Spree::Admin::TaxonsControllerDecorator)