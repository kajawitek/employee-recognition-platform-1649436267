class RewardsQuery
  def initialize(filters: {})
    @filters = filters
  end

  def call
    initialize_collections
    filter_by_categories
    @scoped
  end

  private

  def initialize_collections
    @scoped = Reward.available.includes([:category])
  end

  def filter_by_categories
    @scoped = @scoped.where(category_id: Category.find_by(title: @filters['category']).id) if @filters['category']
  end
end
