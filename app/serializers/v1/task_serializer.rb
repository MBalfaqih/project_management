class V1::TaskSerializer < ActiveModel::Serializer
  attributes :id , :name , :description , :assignee_id , :status 
end
