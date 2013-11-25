class DevicesController < ApplicationController
  before_action :set_device, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :only =>  [:listamisdevices]
  skip_before_filter :verify_authenticity_token, :only => [:cuantos, :listamisdevices]




  # GET /devices
  # GET /devices.json
  def index
    redirect_to root_path
  end

  # GET /devices/1
  # GET /devices/1.json
  def show
  end


  def stopsharing
    if params[:device_id].present? && params[:user_shared].present?
      @device = Device.where("id = ?", params[:device_id])
      @user = User.where("id = ?", params[:user_shared])
      if @device.first.present?
        if @device.first.user_id==current_user.id
          # el device es del usuario
          if @user.first.present?
            # camino normal por el que deberia ir
            Shared.where("device_id = ?",@device.first.id).where("user_shared = ?", @user.first.id).destroy_all
            flash[:notice] ="Ya no comparte " + @device.first.name + "(" + @device.first.imei + ") con " + @user.first.name

          else
            flash[:notice] ="El usuario no existe"

          end
        else
          flash[:notice] ="El dispositivo no es accesible"

        end
      else
        flash[:notice] ="El dispositivo no es accesible"

      end
    end


    redirect_to root_path
  end

  def share
      #localizar que existe el email enun usuario
      u=User.where("email = ?", params[:email])


      if u.first.present?
        a=Shared.new
        a.device_id=params[:device]
        a.user_id =current_user.id
        a.user_shared = u.first.id
        if a.valid?
          a.save
          flash[:notice] = "Ahora compartes el dispositivo con " + u.first.name
        else
          flash[:notice] = "No existe un usuario con ese e-mail"
        end
      else
        flash[:notice] = "No existe un usuario con ese e-mail"
      end

      redirect_to root_path

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
      @device.name = params[:device][:name]
      if @device.save
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

  def cuantos
      respond_to do |format|
        format.json { render json: {:cuantos=>current_user.devices.count} }

      end

  end

  def listamisdevices


    respond_to do |format|
      format.json { render json: {:lista=>current_user.devices.to_json(:methods => [:latitude, :longitude])} }

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
