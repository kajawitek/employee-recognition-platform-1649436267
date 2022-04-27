module Admins
  class KudosController < ApplicationController
    before_action :set_kudo, only: %i[destroy]
    layout 'admin'

    # GET /admins/kudos
    def index
      @kudos = Kudo.all
    end

    # DELETE /admins/kudos/1
    def destroy
      @kudo.destroy
      redirect_to admins_kudos_url, notice: 'Kudo was successfully destroyed.'
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_kudo
      @kudo = Kudo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def kudo_params
      params.require(:kudo).permit(:title, :content, :giver_id, :receiver_id)
    end
  end
end

# DELETE /kudos/1
