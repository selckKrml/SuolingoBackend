class ConversationsController < ApplicationController
  before_action :set_conversation, only: [:show, :update, :destroy]

  # GET /conversations
  # Örnek: API'nin çalıştığını test etmek için JSON response döndürür
  def index
    @conversations = Conversation.includes(:avatar, :learning_path, :messages).all
    
    render json: @conversations.as_json(
      include: {
        avatar: { only: [:id, :name, :voice_id, :image_url, :language, :language_code] },
        learning_path: { only: [:id, :title, :difficulty_level, :description] },
        messages: { only: [:id, :content, :sender_type, :audio_url, :created_at] }
      }
    )
  end

  # GET /conversations/1
  def show
    render json: @conversation.as_json(
      include: {
        avatar: { only: [:id, :name, :voice_id, :personality, :image_url, :language, :language_code] },
        learning_path: { only: [:id, :title, :difficulty_level, :description] },
        messages: { only: [:id, :content, :sender_type, :audio_url, :created_at] }
      }
    )
  end

  # POST /conversations
  def create
    @conversation = Conversation.new(conversation_params)

    if @conversation.save
      render json: @conversation, status: :created, location: @conversation
    else
      render json: @conversation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /conversations/1
  def update
    if @conversation.update(conversation_params)
      render json: @conversation
    else
      render json: @conversation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /conversations/1
  def destroy
    @conversation.destroy!
    head :no_content
  end

  private

  def set_conversation
    @conversation = Conversation.includes(:avatar, :learning_path, :messages).find(params[:id])
  end

  def conversation_params
    params.require(:conversation).permit(:title, :difficulty_level, :learning_path_id, :avatar_id)
  end
end
