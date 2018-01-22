class Project < ApplicationRecord
    
    belongs_to :company
    has_many :project_enrollments
    has_many :employees , through: :project_enrollments 

#    validates :name , :description  , presence: true

end
