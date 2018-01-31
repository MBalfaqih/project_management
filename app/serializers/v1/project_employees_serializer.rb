class V1::ProjectEmployeesSerializer < ActiveModel::Serializer
  attributes :id, :name , :checked?

  def checked?
    selected_project= scope[:pro]
    selected_project.employee_ids.include?(object.id) ? true : false
  end

end
