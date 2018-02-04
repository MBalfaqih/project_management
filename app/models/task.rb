class Task < ApplicationRecord
    belongs_to :project
    belongs_to :employee , foreign_key: "assignee_id" ,  optional: true 

    validates :status , inclusion: { in: %w(completed pending) , 
                                     message: "status must be either pending or completed"}
    
                                     
    validate :presence_of_assignee_id_if_completed #, on: create

    scope :completed , lambda { where(status: "completed") }
    scope :pending   , lambda { where(status:  "pending" ) }

    def reset_assignee_id
        self.assignee_id = nil
        save!
    end

    private

    def presence_of_assignee_id_if_completed
        if status == "completed" && assignee_id.nil?
            errors.add(:assignee_id , I18n.t("assignee_id_must_exist"))
        end
    end

end
