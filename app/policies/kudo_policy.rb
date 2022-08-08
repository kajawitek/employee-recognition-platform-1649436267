class KudoPolicy < ApplicationPolicy
  def initialize(employee, kudo)
    @employee = employee
    @kudo = kudo
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    @kudo.created_at > 5.minutes.ago && @kudo.giver == employee
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end
end
