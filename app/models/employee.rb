class Employee < ApplicationRecord
    extend Enumerize
    
    belongs_to :company
    has_many :employees_projects
    has_many :projects , through: :employees_projects 
    has_many :tasks , foreign_key: "assignee_id" , dependent: :nullify

    ############################################

    validates :name , :joining_date , :birth_date , presence: true
    validate :must_be_over_twenty   
    #validates_format_of :birth_date, :with => /\d{2}\/\d{2}\/\d{4}/, :message => " Date must be in the following format: mm/dd/yyyy"
    #validates :birth_date, :format => /(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d/     

    ############################################

    enumerize :gender, in: [:male, :female]

    private
    def must_be_over_twenty
        if birth_date.present? && (birth_date > 20.years.ago)
                errors.add( :base , " Employee age must be over twenty")
        end
    end
end
