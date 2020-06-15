require 'digest'

module Spree
  module NavigationHelper
    def spree_navigation_data
      taxon_arr = Array.new()
      taxon_category = Spree::Taxon.find_by(name: "Categories")
      taxons = Spree::Taxon.where(parent_id: taxon_category.id, hide_from_nav: false).order(name: :asc)

      taxons.each do |taxon|
        taxon_object = {
          title: taxon.name,
          url: '/t/' + taxon.permalink,
          icon: taxon.icon,
          banner: taxon.banner,
          items: navigation_child(taxon)
        }
        taxon_arr.push(taxon_object)
      end

      taxon_arr || []
    end

    def spree_taxon_homepage
      taxon_arr = Array.new()
      taxon_category = Spree::Taxon.find_by(name: "Categories")
      taxons = Spree::Taxon.where(parent_id: taxon_category.id, show_homepage_list: true)

      taxons.each do |taxon|
        taxon_object = {
          title: taxon.name,
          url: '/t/' + taxon.permalink,
          icon: taxon.icon,
          banner: taxon.banner,
          items: navigation_child(taxon)
        }
        taxon_arr.push(taxon_object)
      end

      taxon_arr || []
    end

    def spree_nav_cache_key(section = 'header')
      base_cache_key + [current_store, spree_navigation_data_cache_key, Spree::Config[:logo], section]
    end

    def main_nav_image(image_path, title = '')
      image_url = asset_path(asset_exists?(image_path) ? image_path : 'noimage/plp.png')

      lazy_image(
        src: image_url,
        alt: title,
        width: 350,
        height: 234
      )
    end

    private

    def spree_navigation_data_cache_key
      @spree_navigation_data_cache_key ||= Digest::MD5.hexdigest(spree_navigation_data.to_s)
    end

    def navigation_child(taxon)
      taxons = Spree::Taxon.where(parent_id: taxon.id, hide_from_nav: false).order(name: :asc)
      taxon_arr = Array.new()

      taxons.each do |taxon|
        taxon_object = {
          title: taxon.name,
          url: '/t/' + taxon.permalink,
          icon: taxon.icon,
          banner: taxon.banner,
        }
        taxon_arr.push(taxon_object)
      end

      taxon_arr || []
    end
  end
end