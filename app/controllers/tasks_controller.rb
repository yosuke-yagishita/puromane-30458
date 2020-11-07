class TasksController < ApplicationController

def create
  @task = Task.new(task_params)
  if @task.save
    redirect_to project_path(@task.project)
  else
    redirect_to project_path(@task.project)
  end
end

def edit
  @task = Task.find(params[:id])
  @project = @task.project
end

def update
  @task = Task.find(params[:id])
  @task.update(task_params)
  if @task.valid?
    redirect_to project_path(@task.project)
  else
    @project = @task.project
    render :edit
  end
end

def destroy
  @task.destroy
  redirect_to project_path(@task.project)
end

  private

  def task_params
    params.require(:task).permit(:task_name, :person_in_charge, :plan, :completion_date).merge(user_id: current_user.id, project_id: params[:project_id])
  end
end
