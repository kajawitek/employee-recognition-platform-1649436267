class RewardsController < ApplicationController
  before_action :authenticate_employee!

  def index
    @rewards = Reward.all.page params[:page]
  end

  def show
    @reward = Reward.find(params[:id])
  end
end
