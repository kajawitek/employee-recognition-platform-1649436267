class ImportRewardsService
  require 'csv'

  attr_reader :errors

  def initialize(file)
    @file = file
    @errors = []
  end

  def call
    return false unless file_exist?
    return false unless format_csv?
    load_file
    return false unless reward_title_unique?
    return false unless reward_category_exists?
    return false unless delivery_method_exists?
    return false unless number_of_available_items_valid?

    ActiveRecord::Base.transaction do
      import_rewards_from_file
    end

    true
  rescue ActiveRecord::RecordInvalid => e
    @errors << e.message
    false
  end

  private

  def file_exist?
    unless @file
      @errors << 'Please add file'
      return false
    end
    true
  end

  def format_csv?
    unless @file.content_type == 'text/csv'
      @errors << 'Please choose CSV file'
      return false
    end
    true
  end

  def load_file
    @file = File.open(@file)
    @csv = CSV.parse(@file, headers: true)
  end

  def reward_title_unique?
    titles = @csv.to_a.map { |row| row[0] }
    unless titles.drop(1) == titles.drop(1).uniq
      @errors << 'Your file has duplicated rewards titles!'
      return false
    end
    true
  end

  def reward_category_exists?
    rewards_categories = @csv.to_a.map { |row| row[3] }
    rewards_categories.drop(1).each do |reward_category|
      unless Category.find_by(title: reward_category)
        @errors << "Category: #{reward_category} doesn't exist"
        return false
      end
    end
    true
  end

  def delivery_method_exists?
    rewards_delivery_methods = @csv.to_a.map { |row| row[4] }
    rewards_delivery_methods.drop(1).each do |reward_delivery_method|
      unless Reward.delivery_methods.values.include?(reward_delivery_method)
        @errors << "Delivery method: #{reward_delivery_method} doesn't exist"
        return false
      end
    end
    true
  end

  def number_of_available_items_valid?
    rewards_number_of_items = @csv.to_a.map { |row| row[5] }
    rewards_number_of_items.drop(1).each_with_index do |reward_number_of_items, index|
      if @csv.to_a.map { |row| row[4] }.drop(1)[index] == 'online' && !reward_number_of_items.to_i.zero?
        @errors << "Number of items: #{reward_number_of_items} should be 0"
        return false
      end
    end
    true
  end

  def import_rewards_from_file
    @csv.each do |row|
      reward = Reward.find_or_initialize_by(title: row['Title'])
      reward.description = row['Description']
      reward.price = row['Price']
      reward.category_id = Category.find_by(title: row['Category']).id
      reward.delivery_method = row['Delivery method']
      reward.number_of_available_items = row['Number of available items (post)'].to_i
      reward.save!
    end
  end
end
