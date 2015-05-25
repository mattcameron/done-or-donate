class TasksController < ApplicationController
	before_action :set_task, only: [:show, :edit, :update, :destroy]

	def index
		@tasks = Task.all
	end

	def show
	end

	def new
		@task = Task.new
	end

	def edit
	end

	def create
    @task = Task.new(task_params)
		@task.user = current_user if logged_in?

      if @task.save && logged_in?
        	redirect_to user_path, notice: 'Task was successfully created.'
      elsif @task.save
      		redirect_to signup_path, notice: "Almost there, sign up to save your task"
      else
				render :new
      end
	end

	def update
	    if @task.update(task_params)
	      redirect_to @task, notice: 'Task was successfully updated.'
	    else
	      render :edit
	    end
	end

	 def destroy
    @task.destroy
      redirect_to tasks_url, notice: 'Task was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

		# Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:title, :description, :due_date, :bounty)
    end
end