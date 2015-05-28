class TasksController < ApplicationController
	before_action :set_task, only: [:show, :edit, :update, :destroy]

	def index
		@user = current_user
		@tasks = @user.tasks
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
    if logged_in?
			@task.user_id = current_user.id
		else
			# create a guest user
			guest = User.create name: "guest", email: "guest", password: "guest"
			# assign the task to the guest
			@task.user_id = guest.id
		end

    if @task.save && logged_in?
      	redirect_to user_path(current_user.id), notice: 'Task was successfully created.'
    elsif @task.save
    		redirect_to "/signup/#{guest.id}", notice: "Almost there, sign up to save your task"
    else
			render :new
    end
	end

	def confirm_task
		@user = User.find(params[:id])
		@task = @user.tasks.first
	end

	def update
	    if @task.update(task_params)
	      redirect_to current_user, notice: "Woohoo!! It's time to get cracking!"
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