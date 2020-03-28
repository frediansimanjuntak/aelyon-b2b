module MyStore
    module Spree
      module VendorDecorator  
        def self.prepended(base)
          base.belongs_to :country, class_name: 'Spree::Country'
          # base.belongs_to :state, class_name: 'Spree::State', optional: true
          base.before_validation :clear_invalid_state_entities, if: -> { country.present? }, on: :update

          base.with_options presence: true do
            validates :name, :company_id, :company_id_type, :city, :country
          end

          base.validate :state_validate, :postal_code_validate
          base.delegate :name, :iso3, :iso, :iso_name, to: :country, prefix: true
          base.delegate :abbr, to: :state, prefix: true, allow_nil: true
        end

        def self.build_default
          new(country: Spree::Country.default)
        end

        def state_text
          state.try(:abbr) || state.try(:name) || state_name
        end

        def to_s
          [
            name,
            "#{city}, #{state_text}",
            country.to_s
          ].reject(&:blank?).map { |attribute| ERB::Util.html_escape(attribute) }.join('<br/>')
        end

        def empty?
          attributes.except('id', 'created_at', 'updated_at', 'country_id').all? { |_, v| v.nil? }
        end

        def active_merchant_hash
          {
            city: city,
            state: state_text,
            country: country.try(:iso),
          }
        end

        def require_zipcode?
          country ? country.zipcode_required? : true
        end

        def clear_invalid_state_entities
          if state.present? && (state.country != country)
            clear_state
          elsif state_name.present? && !country.states_required? && country.states.empty?
            clear_state_name
          end
        end
    
        def state_validate
          # Skip state validation without country (also required)
          # or when disabled by preference
          return if country.blank? || !Spree::Config[:address_requires_state]
          return unless country.states_required
    
          # ensure associated state belongs to country
          if state.present?
            if state.country == country
              clear_state_name # not required as we have a valid state and country combo
            elsif state_name.present?
              clear_state
            else
              errors.add(:state, :invalid)
            end
          end
    
          # ensure state_name belongs to country without states, or that it matches a predefined state name/abbr
          if state_name.present?
            if country.states.present?
              states = country.states.find_all_by_name_or_abbr(state_name)
    
              if states.size == 1
                self.state = states.first
                clear_state_name
              else
                errors.add(:state, :invalid)
              end
            end
          end
    
          # ensure at least one state field is populated
          errors.add :state, :blank if state.blank? && state_name.blank?
        end
    
        def postal_code_validate
          return if country.blank? || country.iso.blank? || !require_zipcode?
          return unless TwitterCldr::Shared::PostalCodes.territories.include?(country.iso.downcase.to_sym)
    
          postal_code = TwitterCldr::Shared::PostalCodes.for_territory(country.iso)
          errors.add(:zipcode, :invalid) unless postal_code.valid?(zipcode.to_s.strip)
        end
      end
    end
  end
  
  ::Spree::Vendor.prepend(MyStore::Spree::VendorDecorator) 