module Spree
  class CategoriesController < Spree::StoreController
    def index
      @taxon_parents = Array.new()
      taxon_category = Spree::Taxon.find_by(name: "Categories")
      taxons = Spree::Taxon.where(parent_id: taxon_category.id).order(name: :asc)

      taxons.each do |taxon|
        taxon_object = {
          title: taxon.name,
          url: '/t/' + taxon.permalink,
          icon: taxon.icon,
          banner: taxon.banner
        }
        @taxon_parents.push(taxon_object)
      end

      @taxon_parents || []
    end

    def show
      @taxon_child = Array.new()
      taxon_category = Spree::Taxon.find_by(name: "Categories")
      taxons = Spree::Taxon.where(parent_id: taxon_category.id).order(name: :asc)

      taxons.each do |taxon|
        taxon_object = {
          title: taxon.name,
          url: '/t/' + taxon.permalink,
          icon: taxon.icon,
          banner: taxon.banner
        }
        @taxon_parents.push(taxon_object)
      end

      @taxon_parents || []
    end
  end
end