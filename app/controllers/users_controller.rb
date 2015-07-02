class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :save_credit_card]

  # GET /users
  def index
    @users = User.all
  end

  def show
    @tasks = @user.tasks.order(:due_date)
  end

  def new
    @guest = User.find(params[:id])
  end

  def edit
    @guest = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      # set the current user for this session
      session[:user_id] = @user.id

      # continue on adding the task
      redirect_to "/users/#{@user.id}/add-credit-card"
    else
      render :new
    end
  end

  # the user's account page
  def account
    @user = current_user
    @tasks = @user.tasks
    render :show
  end

  def add_credit_card
  end

  def save_credit_card
    # first save the credit card
    card = PinPayment::Card.create(
      number:           params[:number],
      expiry_month:     params[:expiry_month],
      expiry_year:      params[:expiry_year],
      cvc:              params[:cvc],
      name:             params[:name]
    )

    # then save the customer in pin.net
    customer = PinPayment::Customer.create( @user.email, card )

    # then store their customer token in the database
    @user.update_attribute(:customer_token, customer.token)

    redirect_to "/users/#{@user.id}/confirm-task"
  end

  def convert_guest_to_user
    @guest = User.find(params[:id])
    if @guest.update(user_params)
      session[:user_id] = @guest.id
      redirect_to "/users/#{@guest.id}/add-credit-card"
    else
      render :new
    end
  end


  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
end
