class EmployeesProject < ApplicationRecord
    belongs_to :project
    belongs_to :employee


    def self.update_project_employees(updated_ids , project)
        # debugger
        remove_unchecked_employees( @unchecked_ids , project ) if @unchecked_ids = project.employee_ids - updated_ids 
        assign_new_employees( @new_assigned_ids , project ) if @new_assigned_ids = updated_ids - project.employee_ids
    end


    def self.update_employee_projects(updated_ids , employee)
        remove_unchecked_projects( @unchecked_ids, employee ) if @unchecked_ids = employee.project_ids - updated_ids 
        assign_new_projects(@new_assigned_ids , employee) if @new_assigned_ids = updated_ids - employee.project_ids
    end

    
    private

    def self.remove_unchecked_projects(unchecked_ids , employee)
        unchecked_ids.each do |id|
            Project.find(id).tasks.where(assignee_id: employee.id ).each { |task| task.reset_assignee_id }    
        end
        employee.projects.destroy(*unchecked_ids) 
    end

    def self.assign_new_projects(new_assigned_ids , employee )
        new_assigned_ids.each { |id| employee.employees_projects.create!(project_id: id)}
    end

    def self.remove_unchecked_employees(unchecked_ids , project)
        unchecked_ids.each do |id|
            Employee.find(id).tasks.where(project_id: project.id).each {|task| task.reset_assignee_id }
            project.employees.destroy(id)
        end
    end

    def self.assign_new_employees(new_assigned_ids , project )
        new_assigned_ids.each{ |id| project.employees_projects.create!(employee_id: id)}
    end

   
end
                                                                             