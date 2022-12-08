module Admins
  class OnlineCodesController < AdminsController
    def index
      render :index, locals: { online_codes: OnlineCode.all.includes(:employee, :reward) }
    end

    def new
      render :new, locals: { online_code: OnlineCode.new }
    end

    def create
      @online_code = OnlineCode.new(online_code_params)
      @online_code.code = SecureRandom.hex(12)
      @online_code.reward.update(number_of_available_items: @online_code.reward.number_of_available_items + 1)
      if @online_code.save
        redirect_to admins_online_codes_path, notice: 'Online code was created.'
      else
        render :new
      end
    end

    def import
      file = params[:file]
      import_service = ImportOnlineCodesService.new(file)
      return redirect_to admins_online_codes_path, notice: import_service.errors.join(', ') unless import_service.call

      redirect_to admins_online_codes_path, notice: 'Online codes imported!'
    end

    private

    def online_code_params
      params.require(:online_code).permit(:reward_id)
    end
  end
end
