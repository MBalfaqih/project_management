class Task < ApplicationRecord
    belongs_to :project
    belongs_to :employee , foreign_key: "assignee_id" ,  optional: true 

    validates :status , inclusion: { in: %w(completed pending) ,
                                     message: "status must be either pending or completed"}
    
    # validates :assignee_id , presence: true , if: status_completed?
    validate :presence_of_assignee_id_if_completed

    scope :completed , lambda { where(status: "completed") }
    scope :pending   , lambda { where(status:  "pending" ) }

    private

    def presence_of_assignee_id_if_completed
        if status == "completed" && assignee_id.nil?
            errors.add(:base , " assignee_id must exist when status = completed ")
        end
    end

end
