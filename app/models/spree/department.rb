class Spree::Department < ApplicationRecord
    has_many :user_references
    has_many :users, :through => :user_references
    has_many :vendors, :through => :user_references
end
