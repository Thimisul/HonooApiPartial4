class MsgsController < ApplicationController
  before_action :set_msg, only: [:show, :update, :destroy]

  # GET /msgs
  def index
    @msgs = Msg.all

    render json: @msgs
  end

  # GET /msgs/1
  def show
    render json: @msg
  end

  # POST /msgs
  def create
    
    @msg = Msg.new(msg_params)

    if @msg.save
      render json: @msg, status: :created, location: @msg, status: :ok
    else
      render json: @msg.errors, status: :bad_request
    end
  end

  # PATCH/PUT /msgs/1
  def update
    if @msg.update(msg_params)
      render json: @msg, status: :ok
    else
      render json: @msg.errors, status: :bad_request
    end
  end

  # DELETE /msgs/1
  def destroy
    @msg.destroy
    render json: { message: "Mensagem deletada!"}, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_msg
      @msg = Msg.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def msg_params
      params.require(:msg).permit(:message, :participantId)
    end
  
end
