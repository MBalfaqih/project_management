class EmployeesProject < ApplicationRecord
    belongs_to :project
    belongs_to :employee

    def self.delete_unchecked_projects(unchecked_ids , employee_id)
        # unchecked_ids = @employee.project_ids - @updated_ids
        unchecked_ids.each { |id|  EmployeesProject.where(employee_id: employee_id ).where(project_id: id ).first.destroy }
    end

    def self.assign_new_checked_projects(new_assigned_ids , employee_id )
        new_assigned_ids.each { |id| EmployeesProject.create(employee_id: employee_id , project_id: id ) } 
    end

    def self.delete_unchecked_employees(unchecked_ids , project_id)
        # unchecked_ids = @employee.project_ids - @updated_ids
        unchecked_ids.each { |id|  EmployeesProject.where(project_id: project_id ).where(employee_id: id ).first.destroy }
    end

    def self.assign_new_checked_employees(new_assigned_ids , project_id )
        new_assigned_ids.each { |id| EmployeesProject.create(project_id: project_id , employee_id: id ) } 
    end

end
