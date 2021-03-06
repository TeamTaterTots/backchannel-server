class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    @channel = Channel.find(params[:channel_id])
    time = params[:ts] || 2.hours.ago
    @messages = @channel.messages.created_after(time)

    render json: @messages
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @channel = Channel.find(params[:channel_id])
    @message = @channel.messages.build(message_params)

    respond_to do |format|
      if @message.save
        format.json { render json: @message, status: :created }
      else
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  #def update
  #  respond_to do |format|
  #   if @message.update(message_params)
  #      format.json { head :no_content }
  #    else
  #      format.json { render json: @message.errors, status: :unprocessable_entity }
  #    end
  #  end
  # end

  # DELETE /messages/1
  # DELETE /messages/1.json
  #def destroy
  #  @message.destroy
  #  respond_to do |format|
  #    format.json { head :no_content }
  #  end
  #end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_message
    @message = Message.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def message_params
    params.require(:message).permit(:channel_id, :nick, :text)
  end
end
