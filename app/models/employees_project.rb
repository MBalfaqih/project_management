class EmployeesProject < ApplicationRecord
    belongs_to :project
    belongs_to :employee

    def self.delete_unchecked_projects(unchecked_ids , employee)
        unchecked_ids.each do |id|
            Project.find(id).tasks.where(assignee_id: employee.id ).each { |task| task.reset_assignee_id }    
        end
        employee.projects.destroy(*unchecked_ids) 
    end

    def self.assign_new_projects(new_assigned_ids , employee )
        new_assigned_ids.each { |id| employee.employees_projects.create!(project_id: id)}
    end

    def self.delete_unchecked_employees(unchecked_ids , project)
        unchecked_ids.each do |id|
            Employee.find(id).tasks.where(project_id: project.id).each {|task| task.reset_assignee_id }
            project.employees.destroy(id)
        end
    end

    def self.assign_new_employees(new_assigned_ids , project )
        new_assigned_ids.each{ |id| project.employees_projects.create!(employee_id: id)}
    end

   
end
                                                                             