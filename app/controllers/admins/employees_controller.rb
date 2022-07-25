module Admins
  class EmployeesController < AdminsController
    def index
      @employees = Employee.all
    end

    def show
      @employee = Employee.find(params[:id])
      @orders = @employee.orders.includes([:reward])
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
      @employee.save!
      redirect_to admins_employees_url(@employee), notice: 'Employee was successfully updated.'
    rescue ActiveRecord::RecordInvalid => e
      render :edit, notice: e.message
    end

    private

    def employee_params
      params.require(:employee).permit(:email, :password, :number_of_available_kudos)
    end

    def employee_params_without_password
      params.require(:employee).permit(:email, :number_of_available_kudos)
    end
  end
end
