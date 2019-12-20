class CarsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_car, only: [:show, :edit, :update, :destroy]

  def index
    @cars = Car.where("user_id = #{current_user.id}").paginate(page: params[:page], per_page: 10)
  end

  def show
  end

  def new
    @car = current_user.cars.build
  end

  def edit
  end

  def create
    @car = current_user.cars.new(car_params)
    @car.avatar.attach(params[:car][:avatar])
    respond_to do |format|
      if @car.save
        format.html { redirect_to cars_url, notice: 'Car was successfully registered.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    @car.avatar.attach(params[:car][:avatar])
    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to cars_url, notice: 'Car was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @car.destroy
    respond_to do |format|
      format.html { redirect_to cars_url, notice: 'Car was successfully destroyed.' }
    end
  end

  private
    def set_car
      @car = Car.find(params[:id])
    end

    def car_params
      params.require(:car).permit(:model, :brand, :user_id)
    end
end
