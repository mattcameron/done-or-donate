class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :save_credit_card]

  # GET /users
  def index
    @users = User.all
  end

  def show
    @tasks = @user.tasks.order(:due_date)
    @successful_tasks_count = @user.successful_tasks.count
    @donated_total = @user.donated_tasks.sum(:bounty)
  end

  # signup form for converting guests to an actual user
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

    # check if credit card details entered are in a valid format before sending to Pin.
    # also, remove whitespace where necessary
    if credit_card_format_is_valid?(params[:number].gsub(/\s+/, ""), params[:expiry_month], params[:expiry_year], params[:cvc].gsub(/\s+/, ""), params[:name])

      # first save the credit card
      card = PinPayment::Card.create(
        number:           params[:number].gsub(/\s+/, ""),
        expiry_month:     params[:expiry_month],
        expiry_year:      params[:expiry_year],
        cvc:              params[:cvc].gsub(/\s+/, ""),
        name:             params[:name]
      )

      # then process an authorisation on the card to check it is valid.
      # TO DO!!

      # then save the customer in pin.net
      customer = PinPayment::Customer.create( @user.email, card )

      # then store their customer token in the database
      @user.update_attribute(:customer_token, customer.token)

      redirect_to "/users/#{@user.id}/confirm-task"
    else
      flash.now[:notice] = "Please enter valid credit card details"
      render :add_credit_card
    end
  end

  def credit_card_format_is_valid?(card_number, expiry_month, expiry_year, cvc, name)
    return false unless [15, 16].include?(card_number.length)
    return false if expiry_year.to_i < Date.today.year
    return false if expiry_year.to_i == Date.today.year && expiry_month.to_i < Date.today.month
    return false unless [3,4].include?(cvc.length)
    return false unless name.strip.split(' ').count >= 2
    true
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
