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

::Spree::Ability.prepend MyStore::Spree::AbilityDecorator if ::Spree::Ability.included_modules.exclude?(MyStore::Spree::AbilityDecorator)
