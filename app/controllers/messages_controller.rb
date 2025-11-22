class MessagesController < ApplicationController
  before_action :set_conversation
  before_action :set_message, only: [:show, :update, :destroy]

  # GET /conversations/:conversation_id/messages
  def index
    @messages = @conversation.messages.order(created_at: :asc)
    render json: @messages
  end

  # GET /conversations/:conversation_id/messages/1
  def show
    render json: @message
  end

  # POST /conversations/:conversation_id/messages
  def create
    @message = @conversation.messages.new(message_params)

    if @message.save
      render json: @message, status: :created
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /conversations/:conversation_id/messages/1
  def update
    if @message.update(message_params)
      render json: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # DELETE /conversations/:conversation_id/messages/1
  def destroy
    @message.destroy!
    head :no_content
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Conversation not found with id: #{params[:conversation_id]}" }, status: :not_found
  end

  def set_message
    @message = @conversation.messages.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Message not found with id: #{params[:id]}" }, status: :not_found
  end

  def message_params
    params.require(:message).permit(:content, :sender_type, :audio_url)
  end
end
