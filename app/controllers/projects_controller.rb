class ProjectsController < ApplicationController
  def index
    @user = User.find(current_user.id)
    @projects = @user.projects
  end

  def show
    get_week
    @project = Project.find(params[:id])
    @task = Task.new
    @tasks = @project.tasks
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
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      redirect_to root_path
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

  def get_week
    wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']

    # Dateオブジェクトは、日付を保持しています。下記のように`.today.day`とすると、今日の日付を取得できます。
    @todays_date = Date.today
    # 例)　今日が2月1日の場合・・・ Date.today.day => 1日

    @week_days = []

    @project = Project.find(params[:id])
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

      # wday_numの定義
      wday_num = Date.today.wday + x
      # wday_numの数値が７以上になった場合の条件分岐
      if wday_num >= 7 then
        wday_num = wday_num - 7
      end
      days = { month: (@todays_date + x).month, date: (@todays_date+x).day, plans: today_plans, wday: wdays[wday_num]}
      @week_days.push(days)
    end
  end
end
