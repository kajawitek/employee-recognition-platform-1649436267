module Admins
  class CategoriesController < AdminsController
    def index
      @categories = Category.all
    end

    def edit
      @category = Category.find(params[:id])
    end

    def new
      @category = Category.new
    end

    def create
      @category = Category.new(category_params)
      @category.save!
      redirect_to admins_categories_path, notice: 'Category was successfully created.'
    rescue ActiveRecord::RecordInvalid => e
      render :new, notice: e.message
    end

    def destroy
      @category = Category.find(params[:id])
      unless Reward.exists?(category_id: @category.id)
        Category.find(params[:id]).destroy
        redirect_to admins_categories_url, notice: 'Category was successfully destroyed.'
      end
      redirect_to admins_categories_url, notice: "This category has rewards. You can't destroy it"
    end

    def update
      @category = Category.find(params[:id])
      @category.update(category_params)
      @category.save!
      redirect_to admins_categories_path, notice: 'Category was successfully updated.'
    rescue ActiveRecord::RecordInvalid => e
      render :edit, notice: e.message
    end

    private

    def category_params
      params.require(:category).permit(:title)
    end
  end
end
