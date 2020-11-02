class ProjectsController < ApplicationController

  def index
    @user = User.find(current_user.id)
    @projects = @user.projects
  end

  def show
    binding.pry
    @project = Project.find(params[:id])
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

  private

  def project_params
    params.require(:project).permit(:title, user_ids: [])
  end

end
