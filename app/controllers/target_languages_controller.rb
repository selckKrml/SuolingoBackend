class TargetLanguagesController < ApplicationController
  before_action :set_target_language, only: [:show, :update, :destroy]

  # GET /target_languages
  def index
    @target_languages = TargetLanguage.all
    render json: @target_languages
  end

  # GET /target_languages/1
  def show
    render json: @target_language
  end

  # POST /target_languages
  def create
    @target_language = TargetLanguage.new(target_language_params)

    if @target_language.save
      render json: @target_language, status: :created, location: @target_language
    else
      render json: @target_language.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /target_languages/1
  def update
    if @target_language.update(target_language_params)
      render json: @target_language
    else
      render json: @target_language.errors, status: :unprocessable_entity
    end
  end

  # DELETE /target_languages/1
  def destroy
    @target_language.destroy!
    head :no_content
  end

  private

  def set_target_language
    @target_language = TargetLanguage.find(params[:id])
  end

  def target_language_params
    params.require(:target_language).permit(:name, :code)
  end
end
