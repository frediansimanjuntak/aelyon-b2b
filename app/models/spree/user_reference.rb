class Spree::UserReference < ApplicationRecord
  belongs_to  :vendor
  belongs_to  :department
  belongs_to  :user
  belongs_to  :role
end
