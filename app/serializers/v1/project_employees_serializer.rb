class V1::ProjectEmployeesSerializer < ActiveModel::Serializer
  attributes :id , :name , :checked?

  def checked?
    debugger
    p = scope[:pro]
    # object
    true if p.employee_ids.include?(id)
  end
end
