class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
      @users = User.all.paginate(page: params[:page], per_page: 10)
  end

  def edit
  end

  def show
  end

  def update
    @user.avatar.attach(params[:user][:avatar])
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to root_url, notice:"User #{@user.id} updated." }
      else
        format.html { render :edit }
      end
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: "User #{@user.id} created." }
      else
        format.html { render :new }
      end
    end
  end

  def destroy
    if @user.id == current_user.id
      redirect_to users_url, notice: "You can't delete yourself."
    else
      @user.destroy
      redirect_to users_url, notice: "User #{@user.id} deleted."
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :lastname, :owner_identification, :owner_card_property, :owner_license, :owner_email, :owner_phone, :owner_address,
    :enterprise, :role, :email, :encrypted_password, :identification, :phone, :reset_password_token, :reset_password_sent_at, :remember_created_at)
  end
end
