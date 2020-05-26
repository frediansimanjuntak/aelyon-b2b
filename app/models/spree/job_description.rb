class Spree::JobDescription < ApplicationRecord
  belongs_to :department
  has_many :user_refs_job_descs
end
