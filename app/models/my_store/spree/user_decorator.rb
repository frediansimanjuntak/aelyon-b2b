module MyStore
    module Spree
      module UserDecorator
        def active_for_authentication?
          super && is_confirmed?
        end

        def confirmed?
          super && is_confirmed?
        end
      end
    end
  end
  
  ::Spree::User.prepend(MyStore::Spree::UserDecorator) 