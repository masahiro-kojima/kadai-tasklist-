class TasksController < ApplicationController

before_action :require_user_logged_in,only: [:index,:show]
before_action :correct_user, only: [:destroy,:show,:edit,:update]

  def index
      @tasks = current_user.tasks.all
  end

  def show

  end


  def new
    if logged_in?
    @task = current_user.tasks.build  # form_with 用
    end
  end


  def create
    @task= current_user.tasks.build(task_params)


    if @task.save
                        # binding.pry
      flash[:success] = 'task が正常に投稿されました'
      redirect_to @task
    else
      @tasks = current_user.tasks.all
      flash.now[:danger] = 'task が投稿されませんでした'
      render 'index'
    end
  end

  def edit
  end


  def update
    if @task.update(task_params)
      flash[:success] = 'task は正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'task は更新されませんでした'
      render :edit
    end
  end


  def destroy

    @task.destroy

    flash[:success] = 'task は正常に削除されました'
    redirect_to root_path
    # redirect_back(fallback_location: root_path)
  end


  private

  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end

  def correct_user
    @task  = current_user.tasks.find_by(id: params[:id])
    unless @task 
    redirect_to root_url
    end
  end
end
