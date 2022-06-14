class RewardsController < ApplicationController
  before_action :authenticate_employee!

  def index
    @rewards = Reward.all
  end

  def show
    @reward = Reward.find(params[:id])
  end
end
