class KudoPolicy < ApplicationPolicy
  def initialize(employee, kudo)
    @employee = employee
    @kudo = kudo
  end

  def update?
    @kudo.created_at > 5.minutes.ago && @kudo.giver == @employee
  end

  def destroy?
    update?
  end
end
