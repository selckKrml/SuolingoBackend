class LearningPathsController < ApplicationController
  before_action :set_learning_path, only: [:show, :update, :destroy]

  # GET /learning_paths
  def index
    @learning_paths = LearningPath.all
    render json: @learning_paths
  end

  # GET /learning_paths/1
  def show
    render json: @learning_path
  end

  # POST /learning_paths
  def create
    @learning_path = LearningPath.new(learning_path_params)

    if @learning_path.save
      render json: @learning_path, status: :created, location: @learning_path
    else
      render json: @learning_path.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /learning_paths/1
  def update
    if @learning_path.update(learning_path_params)
      render json: @learning_path
    else
      render json: @learning_path.errors, status: :unprocessable_entity
    end
  end

  # DELETE /learning_paths/1
  def destroy
    @learning_path.destroy!
    head :no_content
  end

  private

  def set_learning_path
    @learning_path = LearningPath.find(params[:id])
  end

  def learning_path_params
    params.require(:learning_path).permit(:title, :description, :difficulty_level, :estimated_hours, :total_lessons, :is_published)
  end
end
