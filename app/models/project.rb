class Project < ApplicationRecord
    
    belongs_to :company
    has_many :employees_projects
    has_many :employees , through: :employees_projects 
    has_many :tasks

#    validates :name , :description  , presence: true

end
