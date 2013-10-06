class DevicesController < ApplicationController
  before_action :set_device, only: [:show, :edit, :update, :destroy]

  # GET /devices
  # GET /devices.json
  def index
    redirect_to root_path
  end

  # GET /devices/1
  # GET /devices/1.json
  def show
  end

  def verify
    imei=params[:imei]

    d= Device.where('imei= ?',params[:imei]).first
    if d.nil?
      #no existe aun
      a=Device.new
      a.imei=imei
      a.name=""
      a.user_id =current_user.id
      a.save
      flash[:notice] = "Ahora el IMEI " + imei + " está asociado a tu cuenta. No hay datos de ese dispositivo."
      redirect_to root_path

    else
      if d.user_id.nil?
        d.user_id=current_user.id
        d.save

        flash[:notice] = "Ahora el IMEI " + imei + " está asociado a tu cuenta"
        redirect_to root_path

      else
        #d= Device.where('imei= ?',params[:imei]).first
        if d.user_id==current_user.id
          flash[:notice] ="Ese IMEI ya estaba asociado a tu cuenta"
          redirect_to root_path
        else
          flash[:notice] = "Ese IMEI pertenece a otro usuario"
          redirect_to root_path
        end
      end
      #si existe
    end


  end
  # GET /devices/new
  def new
    @device = Device.new
  end

  # GET /devices/1/edit
  def edit
  end


  def assign
  end
  # POST /devices
  # POST /devices.json
  def create
    @device = Device.new(device_params)

    respond_to do |format|
      if @device.save
        format.html { redirect_to @device, notice: 'Device was successfully created.' }
        format.json { render action: 'show', status: :created, location: @device }
      else
        format.html { render action: 'new' }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /devices/1
  # PATCH/PUT /devices/1.json
  def update
    respond_to do |format|
      if @device.update(device_params)
        format.html { redirect_to @device, notice: 'Device was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /devices/1
  # DELETE /devices/1.json
  def destroy
    @device.destroy
    respond_to do |format|
      format.html { redirect_to devices_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device
      @device = Device.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def device_params
      params.require(:device).permit(:imei, :name, :last_seen)
    end
end
