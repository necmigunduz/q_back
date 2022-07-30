class AnswersController < ApplicationController
  before_action :set_answer, only: %i[ show update destroy ]

  # GET /answers
  def index
    @question = Question.find(params[:question_id])
    @answers = @question.answers

    render json: @answers
  end

  # GET /answers/1
  def show
    render json: @answer
  end

  # POST /answers
  def create
    @answer = Answer.new(answer_params)

    if @answer.save
      render json: @answer, status: :created, location: @answer
    else
      render json: @answer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /answers/1
  def update
    if @answer.update(answer_params)
      render json: @answer
    else
      render json: @answer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /answers/1
  def destroy
    @answer.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @question = Question.find(params[:question_id])
      @answer_id = params[:id].to_i 
      @answer = @question.answers[@answer_id]
    end

    # Only allow a list of trusted parameters through.
    def answer_params
      params.require(:answer).permit(:a_text, :a_point, :question_id)
    end
end
