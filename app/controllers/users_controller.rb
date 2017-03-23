class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    valid = true
    @access_key = params[:access_key]
    session = Session.where(:access_key => @access_key)
    if session.empty?
      valid = false
    elsif session.first.lottery_access_revoked
      valid = false
    end
    if !valid
      flash[:error] = "Error invalid permissions for coding problem"
      redirect_to '/'
    else
      return @user
    end
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new
    @user.email = user_params[:email]
    respond_to do |format|
      if @user.save
        format.html { redirect_to sessions_path }
      else
        format.html { render :new }
      end
    end
    access_key = params["access_key"]
    session = Session.where(:access_key => access_key).first
    session.lottery_access_revoked = true
    session.save!
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email)
    end
end
