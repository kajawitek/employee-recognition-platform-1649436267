class RewardsController < ApplicationController
  before_action :authenticate_employee!

  def index
    @categories = Category.all
    @rewards = RewardsQuery.new(filters: index_query_params).call.page params[:page]
  end

  def show
    @reward = Reward.find(params[:id])
  end
end

private

def index_query_params
  params.permit(:category)
end
