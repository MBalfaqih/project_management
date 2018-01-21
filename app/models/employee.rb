class Employee < ApplicationRecord
    
    belongs_to :company

    validates :name , :joining_date , :birth_date , presence: true
    validate :must_be_over_twenty   
    #validates_format_of :birth_date, :with => /\d{2}\/\d{2}\/\d{4}/, :message => " Date must be in the following format: mm/dd/yyyy"
    #validates :birth_date, :format => /(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d/     

    private
    def must_be_over_twenty
        if birth_date.present?
            if birth_date > 20.years.ago
                errors.add( :base , " Employee age must be over twenty")
            end
        end
    end
end
