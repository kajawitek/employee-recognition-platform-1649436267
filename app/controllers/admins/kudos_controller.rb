module Admins
  class KudosController < AdminsController
    before_action :set_kudo, only: %i[destroy]

    def index
      @kudos = Kudo.all
    end

    def destroy
      @kudo.destroy
      redirect_to admins_kudos_url, notice: 'Kudo was successfully destroyed.'
    end

    private

    def set_kudo
      @kudo = Kudo.find(params[:id])
    end

    def kudo_params
      params.require(:kudo).permit(:title, :content, :giver_id, :receiver_id)
    end
  end
end
