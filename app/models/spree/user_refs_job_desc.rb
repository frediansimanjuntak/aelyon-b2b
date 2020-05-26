class Spree::UserRefsJobDesc < ApplicationRecord
    belongs_to  :department
    belongs_to  :user
    belongs_to  :job_description
end
