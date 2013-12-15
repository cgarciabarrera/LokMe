class PointsController < ApplicationController
  before_action :set_point, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except =>  [:manual]
  skip_before_filter :verify_authenticity_token, :only => [:manual]



  # GET /points
  # GET /points.json
  def index
    @points = Point.all
  end


  def manual

    require 'geo-distance'


    latitude=params[:latitude]
    longitude=params[:longitude]
    accuracy = params[:accuracy]
    provider = params[:provider]
    timestamp= params[:timestamp]
    speed = params[:speed]
    height = params[:height]
    course = params[:course]


    #imei=params[:imei]

    pointnew = Point.new
    pointnew.latitude=latitude
    pointnew.longitude=longitude
    pointnew.accuracy=accuracy
    pointnew.provider=provider
    pointnew.speed = speed
    pointnew.height=height
    pointnew.course=course




    id_device=0
    b = Device.find_by_imei(params[:imei])
    if b.present?
      id_device = b.id
    else
      a=Device.new
      a.imei=params[:imei]
      a.name=''
      if a.valid?
        a.save
      else
        render :json => 'KO'

        return false
      end
      a.save
      id_device = a.id
      b=a

    end

    pointnew.device_id = id_device


    if pointnew.valid?
      pointnew.save

      #alarmas

      if b.alarms?
        p "llego aqui"

        ##verificar que tienes alarmas

        a=Alarm.where("device1 = ?", b.id)
        if a.count=0
          b.alarms=false
          b.save
        end
        a.each do |alarm|
          if alarm.tipo=="1"
            dev2 = Device.find(alarm.device2)

            dist = GeoDistance::Haversine.geo_distance(params[:latitude], params[:longitude], dev2.latitude, dev2.longitude).to_meters
            p dist.to_s + " metros"
            if alarm.closer?
              if alarm.distance > dist
                p "se cumple"
                unless alarm.in_progress?
                  b.notificar("Alquien cerca",dev2.name + " de " + dev2.user.name + " se acerca", "Distancia: " + dist.to_s)
                  p "notifico al device"
                  alarm.in_progress=true
                  alarm.save
                end
              else
                p "no se cimple"
                alarm.in_progress=false
                alarm.save
              end
            else

              if dist > alarm.distance
                p "se cumple"
                unless alarm.in_progress?
                  b.notificar("Alquien se aleja",dev2.name + " de " + dev2.user.name + " se aleja", "Distancia: " + dist.to_s)
                  p "notifico"
                  alarm.in_progress=true
                  alarm.save
                end
              else
                p "no se cumple"
                alarm.in_progress=false
                alarm.save
              end
            end
          end
        end



      end



      render :json =>  'OK'
    else
      render :json => 'KO'
    end

  end



  # GET /points/1
  # GET /points/1.json
  def show
  end

  # GET /points/new
  def new
    @point = Point.new
  end

  # GET /points/1/edit
  def edit
  end

  # POST /points
  # POST /points.json
  def create
    @point = Point.new(point_params)

    respond_to do |format|
      if @point.save
        format.html { redirect_to @point, notice: 'Point was successfully created.' }
        format.json { render action: 'show', status: :created, location: @point }
      else
        format.html { render action: 'new' }
        format.json { render json: @point.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /points/1
  # PATCH/PUT /points/1.json
  def update
    respond_to do |format|
      if @point.update(point_params)
        format.html { redirect_to @point, notice: 'Point was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @point.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /points/1
  # DELETE /points/1.json
  def destroy
    @point.destroy
    respond_to do |format|
      format.html { redirect_to points_url }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_point
      @point = Point.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def point_params
      params.require(:point).permit(:latitude, :longitude, :speed, :height, :course, :accuracy, :provider, :timefix)
    end
end
