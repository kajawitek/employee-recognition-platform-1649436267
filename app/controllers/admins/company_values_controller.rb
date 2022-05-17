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
      company_value_duplicate = CompanyValue.find_by(title: company_value_params[:title])

      if company_value_duplicate.present?
        redirect_to new_admins_company_value_url, notice: 'Title must be unique.'
        return
      end

      @company_value = CompanyValue.new(company_value_params)

      if @company_value.title.empty?
        redirect_to new_admins_company_value_url, notice: 'Title is empty. Company Value was not saved.'
      else
        @company_value.save
        redirect_to admins_company_values_path, notice: 'Company Value was successfully created.'

        # end
      end
    end

    def destroy
      @company_value = CompanyValue.find(params[:id])
      @company_value.destroy
      redirect_to admins_company_values_url, notice: 'Company Value was successfully destroyed.'
    end

    def update
      @company_value = CompanyValue.find(params[:id])
      @company_value.update(company_value_params)
      @company_value.save
      redirect_to admins_company_values_url(@company_value), notice: 'Company Value was successfully updated.'
    end

    private

    def company_value_params
      params.require(:company_value).permit(:title)
    end
  end
end
