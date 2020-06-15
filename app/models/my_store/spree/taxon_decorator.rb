module MyStore
  module Spree
    module TaxonDecorator
      def self.prepended(base)
        base.has_one :header_image, as: :viewable, dependent: :destroy, class_name: '::Spree::TaxonHeaderImage'
        base.has_one :banner, as: :viewable, dependent: :destroy, class_name: '::Spree::TaxonBanner'
        base.validates :show_homepage_list, inclusion: { in: [true, false] }
      end      
    end
  end
end

::Spree::Taxon.prepend MyStore::Spree::TaxonDecorator if ::Spree::Taxon.included_modules.exclude?(MyStore::Spree::TaxonDecorator)