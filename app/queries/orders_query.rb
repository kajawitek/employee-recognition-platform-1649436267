class OrdersQuery
  def initialize(employee:, params: {})
    @params = params
    @employee = employee
  end

  def call
    initialize_colletions
    filter_by_delivery_status
    @scoped
  end

  private

  def initialize_colletions
    @scoped = @employee.orders
  end

  def filter_by_delivery_status
    return unless @params['delivery_status']

    @scoped = @scoped.delivered if @params['delivery_status'] == 'delivered'
    @scoped = @scoped.ordered if @params['delivery_status'] == 'ordered'
  end
end
