module Admins
  class EmployeesController < AdminsController
    # GET /admins/kudos
    def index
      @employees = Employee.all
    end

    def show
      @employee = Employee.find(params[:id])
    end

    def edit
      @employee = Employee.find(params[:id])
    end

    def destroy
      @employee = Employee.find(params[:id])
      @employee.destroy
      redirect_to admins_employees_url, notice: 'Employee was successfully destroyed.'
    end

    def update
      @employee = Employee.find(params[:id])
      if params[:employee][:password].blank?
        @employee.update(employee_params_without_password)

      else
        @employee.update(employee_params)

      end
      @employee.save
      redirect_to admins_employees_url(@employee), notice: 'Employee was successfully updated.'
    end

    private

    def employee_params
      params.require(:employee).permit(:email, :password, :number_of_available_kudos)
    end

    def employee_params_without_password
      params.require(:employee).permit(:email, :number_of_available_kudos)
    end
  end

  #       # DELETE /admins/kudos/1
  #       def destroy
  #         @kudo.destroy
  #         redirect_to admins_kudos_url, notice: 'Kudo was successfully destroyed.'
  #       end

  #       private

  #       # Use callbacks to share common setup or constraints between actions.
  #       def set_kudo
  #         @kudo = Kudo.find(params[:id])
  #       end

  #       # Only allow a list of trusted parameters through.
  #       def kudo_params
  #         params.require(:kudo).permit(:title, :content, :giver_id, :receiver_id)
  #       end
end

#   # DELETE /kudos/1
