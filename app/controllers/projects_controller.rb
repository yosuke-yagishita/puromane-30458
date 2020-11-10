class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update]
  
  def index
    @user = User.find(current_user.id)
    @projects = @user.projects
  end

  def show
    get_week
    @task = Task.new
    @tasks = @project.tasks.order(plan: "ASC")
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to project_path(params[:id])
    else
      render :edit
    end
  end

  def destroy
    project = Project.find(params[:id])
    project.destroy
    redirect_to root_path
  end

  private

  def project_params
    params.require(:project).permit(:title, user_ids: [])
  end

  def set_project
    @project = Project.find(params[:id])
  end

  def get_week
    wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']

    @todays_date = Date.today

    @week_days = []

    @project = Project.find(params[:id])
    tasks = @project.tasks.order(plan: "ASC")

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
