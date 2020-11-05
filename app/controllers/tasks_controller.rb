class TasksController < ApplicationController

def create
  @task = Task.new(task_params)
  if @task.save
    redirect_to project_path(@task.project)
  else
    @project = @task.project
    @tasks = @project.tasks
    render "projects/show"
  end
end

  private

  def task_params
    params.require(:task).permit(:task_name, :person_in_charge, :plan, :completion_date).merge(project_id: params[:project_id])
  end
end
