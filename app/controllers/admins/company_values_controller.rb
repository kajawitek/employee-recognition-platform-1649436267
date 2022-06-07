module Admins
  class CompanyValuesController < AdminsController
    def index
      @company_values = CompanyValue.all
    end

    def show
      @company_value = CompanyValue.find(params[:id])
    end

    def edit
      @company_value = CompanyValue.find(params[:id])
    end

    def new
      @company_value = CompanyValue.new
    end

    def create
      @company_value = CompanyValue.new(company_value_params)
      @company_value.save!
      redirect_to admins_company_values_path, notice: 'Company Value was successfully created.'
    rescue ActiveRecord::RecordInvalid => e
      render :new, notice: e.message
    end

    def destroy
      @company_value = CompanyValue.find(params[:id])
      @company_value.destroy
      redirect_to admins_company_values_url, notice: 'Company Value was successfully destroyed.'
    end

    def update
      @company_value = CompanyValue.find(params[:id])
      @company_value.update(company_value_params)
      @company_value.save!
      redirect_to admins_company_values_path, notice: 'Company Value was successfully updated.'
    rescue ActiveRecord::RecordInvalid => e
      render :edit, notice: e.message
    end

    private

    def company_value_params
      params.require(:company_value).permit(:title)
    end
  end
end
