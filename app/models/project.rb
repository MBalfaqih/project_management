class Project < ApplicationRecord
    belongs_to :company

   # validates :name , :description  , presence: true

end
