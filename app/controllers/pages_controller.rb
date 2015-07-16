class PagesController < ApplicationController

  skip_before_filter :login_required

	def index
		@task = Task.new
    @task_count = Task.count
    @success_count = Task.where(done_or_donated: "done").count
    @donations = Charge.sum(:total_cents) / 100
    @users = User.count
	end

	def signup

	end

	def new

	end

	#logging in
  def create
    @user = User.find_by(email: params[:email])

    #check if we have @user and password is correct
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to account_path
    else
      # incorrect email or password
      redirect_to :back, notice: "Login was unsuccessful. Please try again."
    end
  end

  #logging out
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end