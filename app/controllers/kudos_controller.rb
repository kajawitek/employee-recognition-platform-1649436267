class KudosController < ApplicationController
  before_action :set_kudo, only: %i[show edit update destroy]
  before_action :authenticate_employee!

  # GET /kudos
  def index
    @kudos = Kudo.all
  end

  # GET /kudos/1
  def show; end

  # GET /kudos/new
  def new
    @kudo = Kudo.new
  end

  # GET /kudos/1/edit
  def edit
    redirect_to kudos_path, notice: 'You are not owner of this kudo.' if @kudo.giver_id != current_employee.id
  end

  def create
    if current_employee.number_of_available_kudos.zero?
      redirect_to kudos_path, notice: 'Kudo was not  created. Your number of available kudos is 0'
    else
      @kudo = Kudo.new(kudo_params)
      @kudo.giver = current_employee

      if @kudo.save
        @kudo.giver.number_of_available_kudos -= 1
        @kudo.giver.save

        redirect_to kudos_url, notice: 'Kudo was successfully created.'

      else
        render :new
      end
    end
  end

  # PATCH/PUT /kudos/1
  def update
    if @kudo.giver_id != current_employee.id
      redirect_to kudos_path, notice: 'You are not owner of this kudo.'
    elsif @kudo.update(kudo_params)
      redirect_to @kudo, notice: 'Kudo was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /kudos/1
  def destroy
    if @kudo.giver_id == current_employee.id
      @kudo.destroy
      redirect_to kudos_url, notice: 'Kudo was successfully destroyed.'
    else
      redirect_to kudos_path, notice: 'You are not owner of this kudo.'
    end
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
