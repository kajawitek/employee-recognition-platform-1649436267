module Admins
  class RewardsController < AdminsController
    def index
      @rewards = Reward.all
    end

    def show
      @reward = Reward.find(params[:id])
    end

    def edit
      @reward = Reward.find(params[:id])
    end

    def new
      @reward = Reward.new
    end

    def create
      @reward = Reward.new(reward_params)
      @reward.save!
      redirect_to admins_rewards_path, notice: 'Reward was successfully created.'
    rescue ActiveRecord::RecordInvalid => e
      render :new, notice: e.message
    end

    def destroy
      @reward = Reward.find(params[:id])
      @reward.destroy
      redirect_to admins_rewards_url, notice: 'Reward was successfully destroyed.'
    end

    def update
      @reward = Reward.find(params[:id])
      @reward.update(reward_params)
      @reward.save!
      redirect_to admins_rewards_path, notice: 'Reward was successfully updated.'
    rescue ActiveRecord::RecordInvalid => e
      render :edit, notice: e.message
    end

    private

    def reward_params
      params.require(:reward).permit(:title, :description, :price)
    end
  end
end
