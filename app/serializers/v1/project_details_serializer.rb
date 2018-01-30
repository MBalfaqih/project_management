class V1::ProjectDetailsSerializer < V1::ProjectSerializer
  attributes  :tasks_count , :completed_task , :assigined_tasks

  def tasks_count
    object.tasks.count
  end

  def completed_task
    object.tasks.completed.count
  end

  def assigined_tasks
    object.tasks.where.not(assignee_id: "nil").count
  end
end