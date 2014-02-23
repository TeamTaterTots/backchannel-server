class ChannelsController < ApplicationController
  before_action :set_channel, only: [:show, :edit, :update, :destroy]

  # GET /channels
  # GET /channels.json
  def index
    @channels = Channel.find_nearby(params[:place_id])
    render json: @channels
  end

  # GET /channels/1
  # GET /channels/1.json
  def show
    respond_to do |format|
      format.json { render json: @channel }
    end
  end

  # GET /channels/new
  def new
  end

  # GET /channels/1/edit
  def edit
  end

  # POST /channels
  # POST /channels.json
  def create
    begin
      @place = Place.find(params[:place_id])
    rescue ActiveRecord::RecordNotFound => e
      @place = Place.new
      @place.foursquare_venue_id = params[:place_id]
      @place.save
    end
    @channel = @place.channels.build(channel_params)

    respond_to do |format|
      if @channel.save
        format.json { render json: @channel, status: :created, location: @channel }
      else
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /channels/1
  # PATCH/PUT /channels/1.json
  def update
    respond_to do |format|
      if @channel.update(channel_params)
        # format.html { redirect_to @channel, notice: 'Channel was successfully updated.' }
        format.json { head :no_content }
      else
        # format.html { render action: 'edit' }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /channels/1
  # DELETE /channels/1.json
  def destroy
    @channel.destroy
    respond_to do |format|
      format.html { redirect_to channels_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_channel
      @channel = Channel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def channel_params
      params.require(:channel).permit(:place_id, :name)
    end
end
