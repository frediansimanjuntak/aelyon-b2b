module Spree
  class TaxonHeaderImage < Asset
    has_one_attached :attachment
  end
end