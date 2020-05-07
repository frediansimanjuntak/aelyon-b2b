module MyStore
  module Spree
    module VendorDecorator  
      def self.prepended(base)
        base.has_one :vendor_detail
        base.has_many :user_references
        base.has_many :users, :through => :user_references
        base.has_many :departments, :through => :user_references
      end

      
    end
  end
end

::Spree::Vendor.prepend(MyStore::Spree::VendorDecorator) 