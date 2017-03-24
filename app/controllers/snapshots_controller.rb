class SnapshotsController < ApplicationController
  before_action :set_snapshot, only: [:show, :edit, :update, :destroy]

  # GET /snapshots
  # GET /snapshots.json
  def index
    @snapshots = Snapshot.all
  end

  # GET /snapshots/1
  # GET /snapshots/1.json
  def show
  end

  # GET /snapshots/new
  def new
    @snapshot = Snapshot.new
    @access_key = params[:access_key]   
  end

  # GET /snapshots/1/edit
  def edit
  end

  # POST /snapshots
  # POST /snapshots.json
  def create
    valid = true
    access_key = params[:access_key]
    session = Session.where(:access_key => access_key)
    if session.empty?
      valid = false
    elsif session.first.coding_access_revoked
      valid = false
    end
    if !valid
      respond_to do |format|
        format.html do 
          flash[:error] = "Error invalid permissions for coding problem"
          redirect_to '/'
        end
        format.json do 
          render status: 401, json: {status: 401}
        end
      end
      return
    end
    session_id = params[:session_id]
    snapshots = params[:body]
    session = Session.where(:access_key => access_key).first
    snapshots.each do |k, snapshot|
      s = Snapshot.new
      s.session_id = session.id
      s.body = snapshot["body"]
      s.recorded_at = Time.at(snapshot["time"].to_i/1000)
      s.save!
    end
    session.coding_access_revoked = true
    session.save!
    redirect_to "/users/new?access_key=#{access_key}"
  end

  # PATCH/PUT /snapshots/1
  # PATCH/PUT /snapshots/1.json
  def update
    respond_to do |format|
      if @snapshot.update(snapshot_params)
        format.html { redirect_to @snapshot, notice: 'Snapshot was successfully updated.' }
        format.json { render :show, status: :ok, location: @snapshot }
      else
        format.html { render :edit }
        format.json { render json: @snapshot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /snapshots/1
  # DELETE /snapshots/1.json
  def destroy
    @snapshot.destroy
    respond_to do |format|
      format.html { redirect_to snapshots_url, notice: 'Snapshot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_snapshot
      @snapshot = Snapshot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def snapshot_params
      params.permit(:body, :session_id)
    end
end
