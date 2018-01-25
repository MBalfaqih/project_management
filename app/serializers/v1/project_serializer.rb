class V1::ProjectSerializer < ActiveModel::Serializer
  attributes :id , :name , :description # , :tasks_count , :completed_task , :assigined_tasks
end

# def tasks_count
# end
# 
# def completed_task
# end
# 
# def assigined_tasks
# end