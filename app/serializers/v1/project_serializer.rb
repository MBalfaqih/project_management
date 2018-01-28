class V1::ProjectSerializer < ActiveModel::Serializer
  attributes :id , :name , :description  , :tasks_count , :completed_task , :assigined_tasks
end

def tasks_count
  self.tasks.count
end

def completed_task
  self.tasks.completed.count
end

def assigined_tasks
  self.tasks.where.not(assignee_id: "nil").count
end 