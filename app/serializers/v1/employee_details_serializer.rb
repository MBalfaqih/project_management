class V1::EmployeeDetailsSerializer < V1::EmployeeSerializer
  attributes :projects_count  , :tasks_count
  has_many :tasks


  def projects_count
    object.projects.count
  end

  def tasks_count
    object.tasks.count
  end

end

