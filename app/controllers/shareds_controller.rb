class SharedsController < ApplicationController
  before_action :set_shared, only: [:show, :edit, :update, :destroy]

  # GET /shareds
  # GET /shareds.json
  def index
    @shareds = Shared.all
  end

  # GET /shareds/1
  # GET /shareds/1.json
  def show
  end

  # GET /shareds/new
  def new
    @shared = Shared.new
  end

  # GET /shareds/1/edit
  def edit
  end

  # POST /shareds
  # POST /shareds.json
  def create
    @shared = Shared.new(shared_params)

    respond_to do |format|
      if @shared.save
        format.html { redirect_to @shared, notice: 'Shared was successfully created.' }
        format.json { render action: 'show', status: :created, location: @shared }
      else
        format.html { render action: 'new' }
        format.json { render json: @shared.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shareds/1
  # PATCH/PUT /shareds/1.json
  def update
    respond_to do |format|
      if @shared.update(shared_params)
        format.html { redirect_to @shared, notice: 'Shared was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @shared.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shareds/1
  # DELETE /shareds/1.json
  def destroy
    @shared.destroy
    respond_to do |format|
      format.html { redirect_to shareds_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shared
      @shared = Shared.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shared_params
      params.require(:shared).permit(:device_id, :user_id, :user_shared, :from_date, :to_date, :visibility)
    end
end
