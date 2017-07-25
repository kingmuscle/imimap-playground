class FavoriteProjectsController < ApplicationController
  before_filter :authorize

  before_action :set_project

  def create
    if Favorite.create(favorited: @project, user: current_user)
      redirect_to @project, notice: 'Project has been favorited'
    else
      redirect_to @project, alert: 'Something went wrong...*sad panda*'
    end
  end

  def destroy
    Favorite.where(favorited_id: @project.id, user_id: current_user.id).first.destroy
    redirect_to @project, notice: 'Project is no longer in favorites'
  end

  private

  def set_project
    @project = Project.find(params[:project_id] || params[:id])
  end
end
