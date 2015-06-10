class TasksController < ApplicationController
	before_action :set_task, only: [:show, :edit, :update, :destroy, :completed]

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


# On the home page, if a user is not logged in, the task they create is assigned to a 'guest' user. We then update this task to their details once they have created an account.
# If the user is already logged in, it is simply assigned to them.
	def create
    @task = Task.new(edited_params)
    if logged_in?
			@task.user_id = current_user.id
		else
			# create a guest user
			guest = User.create name: "guest", email: "guest", password: "guest"
			# assign the task to the guest
			@task.user_id = guest.id
		end

    if logged_in? && @task.save
    		# return to the user's account page
      	redirect_to user_path(current_user.id), notice: 'Task was successfully created.'
    elsif @task.save
    		# make the user signup first
    		redirect_to "/signup/#{guest.id}", notice: "Almost there, sign up to save your task"
    else
			render :new
    end
	end


# confirm task and add more details if necessary.
	def confirm_task
		@user = current_user
		@task = @user.tasks.first
	end


# updates the task with any changes from the confirm_task page
	def update
	    if @task.update(edited_params)
	      redirect_to current_user, notice: "Woohoo!! It's time to get cracking!"
	    else
	      render :edit
	    end
	end


# Set the task as completed and mark it as 'done'
	def completed
		@task.completed = true
		@task.done_or_donated = "done"
		@task.save

		# will soon be using AJAX to post completed tasks, and prevent page reload
		respond_to do |format|
		  format.html {redirect_to user_path(@task.user.id)}
		  format.json { render json: @task }
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

    def edited_params
    	# convert the due_date into the UTC equivalent of the user's timezone
			edited_params = task_params
			edited_params[:due_date] = DateTime.parse(edited_params[:due_date]) + params[:task_timezone_offset].to_i.minute
			edited_params
    end
end