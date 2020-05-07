module MyStore
  module Spree
    module AbilityDecorator
      private
      def abilities_to_register
        super << ::Spree::DepartmentAbility
      end
    end
  end
end

::Spree::Ability.prepend(MyStore::Spree::AbilityDecorator) 