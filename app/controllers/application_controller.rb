# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :employee_not_authorized

  def pundit_user
    current_employee
  end

  private

  def employee_not_authorized
    redirect_to root_path, notice: 'You are not authorized to perform this action.'
  end
end
