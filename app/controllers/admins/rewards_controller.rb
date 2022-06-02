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

      if @reward.title.empty?
        redirect_to new_admins_reward_url, notice: 'Title is empty. Reward was not saved.'
      elsif @reward.content.empty?
        redirect_to new_admins_reward_url, notice: 'Content is empty. Reward was not saved.'
      elsif @reward.price.nil? || @reward.price < 1
        redirect_to new_admins_reward_url, notice: 'Price is empty or less than 1. Reward was not saved.'
      else
        @reward.save
        redirect_to admins_rewards_path, notice: 'Reward was successfully created.'
      end
    end

    def destroy
      @reward = Reward.find(params[:id])
      @reward.destroy
      redirect_to admins_rewards_url, notice: 'Reward was successfully destroyed.'
    end

    def update
      @reward = Reward.find(params[:id])
      @reward.update(reward_params)
      if @reward.title.empty?
        redirect_to edit_admins_reward_url, notice: 'Title is empty. Reward was not updated.'
      elsif @reward.content.empty?
        redirect_to edit_admins_reward_url, notice: 'Content is empty. Reward was not updated.'
      elsif @reward.price.nil? || @reward.price < 1
        redirect_to edit_admins_reward_url, notice: 'Price is empty or less than 1. Reward was not updated.'
      else
        @reward.save
        redirect_to admins_rewards_path, notice: 'Reward was successfully updated.'
      end
    end

    private

    def reward_params
      params.require(:reward).permit(:title, :content, :price)
    end
  end
end
