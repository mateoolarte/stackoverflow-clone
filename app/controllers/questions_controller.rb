class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  before_action :find_question, only: [:show]

  def index
    @questions = Question.order(created_at: :desc)

    @questions = @questions.where("title || description ILIKE ?", "%#{params[:query]}%") if params[:query].present?
  end

  def new
    @question = Question.new
  end  

  def show

  end

  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to questions_path, notice: "La pregunta fue creada con éxito"
    else
      render :new  
    end  
  end

  private
  def question_params
    params.require(:question).permit(:title, :description).merge(user: current_user)
  end

  def find_question
    @question = Question.find(params[:id])
  end
end
