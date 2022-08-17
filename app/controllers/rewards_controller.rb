class RewardsController < ApplicationController
  before_action :authenticate_employee!

  def index
    @categories = Category.all
    @rewards = RewardsQuery.new(categories: @categories, rewards: (Reward.all.page params[:page]), params: params).call.includes([:category])
  end

  def show
    @reward = Reward.find(params[:id])
  end
end
