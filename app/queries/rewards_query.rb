class RewardsQuery
  def initialize(rewards:, categories:, params: {})
    @params = params
    @rewards = rewards
    @categories = categories
  end

  def call
    initialize_colletions
    filter_by_categories
    @scoped
  end

  private

  def initialize_colletions
    @scoped = @rewards
  end

  def filter_by_categories
    return unless @params['category']

    @scoped = @scoped.where(category: Category.find_by(title: @params['category']))
  end
end
