class TasksController < ApplicationController

def create
  get_week
  @task = Task.new(task_params)
  @tasks = @project.tasks
  @project = @task.project
  if @task.save
    redirect_to project_path(@task.project)
  else
    render "projects/show"
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

  def get_week
    wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']

    @todays_date = Date.today

    @week_days = []

    @project = Project.find(params[:project_id])
    tasks = @project.tasks

    7.times do |x|
      today_plans = []
      task = tasks.map do |task|
        if (task.plan == @todays_date + x) && (task.completion_date == @todays_date + x)
          today_plans.push('★')
        elsif task.plan == @todays_date + x
          today_plans.push('○')
        elsif task.completion_date == @todays_date + x
          today_plans.push('●')
        else
          today_plans.push('ー')
        end
      end

      wday_num = Date.today.wday + x
      if wday_num >= 7 then
        wday_num = wday_num - 7
      end
      days = { month: (@todays_date + x).month, date: (@todays_date+x).day, plans: today_plans, wday: wdays[wday_num]}
      @week_days.push(days)
    end
  end
end
