class V1::EmployeeSerializer < ActiveModel::Serializer
  attributes :id, :name, :gender, :birth_date, :joining_date 
end

