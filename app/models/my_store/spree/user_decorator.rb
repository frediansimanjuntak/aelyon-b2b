module MyStore
  module Spree
    module UserDecorator
      def self.prepended(base)
        base.has_many :user_references
        base.has_many :vendors, :through => :user_references
        base.has_many :departments, :through => :user_references
      end

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