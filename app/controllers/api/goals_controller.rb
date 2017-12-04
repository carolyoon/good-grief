class Api::GoalsController < ApplicationController
  protect_from_forgery with: :null_session

  before_action :find_goal, only: [:update, :destroy]
  # before_action :authenticate_user

  def index
    @user = User.find_by(id: params[:user_id])
    @goals = @user.goals

    render json: @goals
  end

  def create
    @goal = Goal.new(goal_params)

    if @goal.save
      render json: {goal: @goal}
    else
      render json: {errors: @goal.errors.full_messages}, status: 422
    end
  end

  def update
    if @goal.update(goal_params)
      render json: {goal: @goal}
    else
      render json: {error: @goal.errors.full_messages}, status: 422
    end
  end

  def destroy
    @goal.destroy
  end

  private

  def find_goal
    @goal = Goal.find(params[:id])
  end

  def goal_params
    params.require(:goal).permit(:content, :completed)
  end

end
