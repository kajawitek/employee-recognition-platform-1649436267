class KudosController < ApplicationController
  before_action :set_kudo, only: %i[show edit update destroy]
  before_action :authenticate_employee!

  def index
    @kudos = Kudo.includes(%i[giver receiver company_value]).all
  end

  def show; end

  def new
    @kudo = Kudo.new
  end

  def edit
    authorize @kudo
  end

  def create
    if current_employee.number_of_available_kudos.zero?
      redirect_to kudos_path, notice: 'Kudo was not  created. Your number of available kudos is 0'
    else
      @kudo = Kudo.new(kudo_params)
      @kudo.giver = current_employee
      @kudo.giver.number_of_available_kudos -= 1
      @kudo.receiver.number_of_available_points += 1
      begin
        ActiveRecord::Base.transaction do
          @kudo.giver.save!
          @kudo.receiver.save!
          @kudo.save!
        end
        redirect_to kudos_url, notice: 'Kudo was successfully created.'
      rescue ActiveRecord::RecordInvalid => e
        render :new, notice: e.message
      end
    end
  end

  def update
    authorize @kudo
    if @kudo.update(kudo_params)
      redirect_to @kudo, notice: 'Kudo was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @kudo
    @kudo.receiver.number_of_available_points -= 1
    begin
      ActiveRecord::Base.transaction do
        @kudo.receiver.save!
        @kudo.destroy!
      end
      redirect_to kudos_url, notice: 'Kudo was successfully destroyed.'
    rescue ActiveRecord::RecordInvalid => e
      render :new, notice: e.message
    end
  end

  private

  def set_kudo
    @kudo = Kudo.find(params[:id])
  end

  def kudo_params
    params.require(:kudo).permit(:title, :content, :giver_id, :receiver_id, :company_value_id)
  end
end
