class ImportRewardService
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

    ActiveRecord::Base.transaction do
      import_file
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
    unless titles == titles.uniq
      @errors << 'Your file have duplicated rewards titles!'
      return false
    end
    true
  end

  def import_file
    @csv.each do |row|
      reward = Reward.find_or_initialize_by(title: row['Title'])
      reward.description = row['Description']
      reward.price = row['Price']
      reward.category_id = Category.find_by(title: row['Category']).id
      reward.save!
    end
  end
end
