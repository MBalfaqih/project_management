class V1::EmployeeProjectsSerializer < ActiveModel::Serializer
  attributes :id , :name , :checked?

  def checked?
    selected_employee = scope[:emp]
    selected_employee.project_ids.include?(object.id) ? true : false
  end
end
