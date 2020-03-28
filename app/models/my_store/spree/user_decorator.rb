module MyStore
    module Spree
      module UserDecorator
  
        def self.prepended(base)
            
        end
      end
    end
  end
  
  ::Spree::User.prepend(MyStore::Spree::UserDecorator) 