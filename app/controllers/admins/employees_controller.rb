module Admins
  class EmployeesController < AdminsController
    def index
      @employees = Employee.all
    end

    def show
      @employee = Employee.find(params[:id])
      @orders = @employee.orders.includes([:reward]).order(delivery_status: :desc)
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

    def add_available_kudos
      unless params[:number_of_additional_kudos].to_i.between? 1, 20
        redirect_to admins_employees_path, notice: 'Additional kudos must be between 1 and 20' and return
      end

      begin
        ActiveRecord::Base.transaction do
          Employee.all.each do |employee|
            employee.update!(number_of_available_kudos: employee.number_of_available_kudos + params[:number_of_additional_kudos].to_i)
          end
        end
        redirect_to admins_employees_path, notice: 'Additional kudos added'
      rescue ActiveRecord::RecordInvalid
        redirect_to admins_employees_path, notice: 'Error: Additional kudos not added'
      end
    end

    private

    def employee_params
      params.require(:employee).permit(:email, :password, :number_of_available_kudos, :first_name, :last_name)
    end

    def employee_params_without_password
      params.require(:employee).permit(:email, :number_of_available_kudos, :first_name, :last_name)
    end
  end
end
