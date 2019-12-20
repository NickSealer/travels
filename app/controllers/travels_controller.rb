class TravelsController < ApplicationController
  before_action :set_travel, only: [:show, :edit, :update, :destroy]

  # GET /travels
  # GET /travels.json
  def index
    @travels = Travel.where("user_id = #{current_user.id}").paginate(page: params[:page], per_page: 10)
    @admin_travels = Travel.all.paginate(page: params[:page], per_page: 10)
  end

  # GET /travels/1
  # GET /travels/1.json
  def show
  end

  # GET /travels/new
  def new
    @travel = current_user.travels.build
  end

  # GET /travels/1/edit
  def edit
  end

  # POST /travels
  # POST /travels.json
  def create
    @travel = current_user.travels.new(travel_params)
    @user = User.new
    @user.role = "User"
    @user.phone = @travel.user_phone
    @user.email = @travel.user_email
    @user.password = @travel.user_identification
    @user.identification = @travel.user_identification

    respond_to do |format|
      if @travel.save
        @user.save
        UserMailer.send_contract(current_user.email, @travel).deliver_now
        UserMailer.send_contract(@travel.user_email, @travel).deliver_now
        format.html { redirect_to @travel, notice: 'Travel was successfully created.' }
        format.json { render :show, status: :created, location: @travel }
        format.pdf { render template:'travels\travel.pdf.erb', pdf:'Contract' }
      else
        format.html { render :new }
        format.json { render json: @travel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /travels/1
  # PATCH/PUT /travels/1.json
  def update
    UserMailer.send_contract(current_user.email, @travel).deliver_now
    UserMailer.send_contract(@travel.user_email, @travel).deliver_now
    respond_to do |format|
      if @travel.update(travel_params)
        UserMailer.send_contract(current_user.email, @travel, origin = "OtroSi").deliver_now
        UserMailer.send_contract(@travel.user_email, @travel, origin = "OtroSi").deliver_now
        format.html { redirect_to @travel, notice: 'Travel was successfully updated.' }
        format.json { render :show, status: :ok, location: @travel }
      else
        format.html { render :edit }
        format.json { render json: @travel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /travels/1
  # DELETE /travels/1.json
  def destroy
    @travel.destroy
    respond_to do |format|
      format.html { redirect_to travels_url, notice: 'Travel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_travel
      @travel = Travel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def travel_params
      params.require(:travel).permit(:time, :distance, :value, :user_identification, :user_phone, :user_email, :user_id)
    end
end
