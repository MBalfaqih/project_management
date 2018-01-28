class V1::EmployeeSerializer < ActiveModel::Serializer
  attributes :id , :name , :birth_date , :joining_date , :projects_count  , :tasks_count
   has_many :tasks
end

def projects_count
  self.projects.count
end

def tasks_count
  self.tasks.count
end