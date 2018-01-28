class Project < ApplicationRecord
    
    belongs_to :company
    has_many :employees_projects
    has_many :employees , through: :employees_projects 
    has_many :tasks , dependent: :destroy

#    validates :name , :description  , presence: true

end
