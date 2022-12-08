class ImportOnlineCodesService
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
    return false unless online_code_reward_exists?
    return false unless online_code_reward_is_online?
    return false unless added_reward_valid?

    ActiveRecord::Base.transaction do
      import_online_codes_from_file
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

  def online_code_reward_exists?
    online_code_rewards = @csv.to_a.map { |row| row[0] }
    online_code_rewards.drop(1).each do |online_code_reward|
      unless Reward.find_by(title: online_code_reward)
        @errors << "Reward: #{online_code_reward} doesn't exist"
        return false
      end
    end
    true
  end

  def online_code_reward_is_online?
    online_code_rewards = @csv.to_a.map { |row| row[0] }
    online_code_rewards.drop(1).each do |online_code_reward|
      unless Reward.find_by(title: online_code_reward).online?
        @errors << "Reward: #{online_code_reward} have post delivery method. You can't create online code for it"
        return false
      end
    end
    true
  end

  def added_reward_valid?
    online_code_rewards = @csv.to_a.map { |row| row[0] }
    online_code_rewards.drop(1).each do |online_code_reward|
      unless Reward.find_by(title: online_code_reward)
        @errors << "Reward: #{online_code_reward} doesn't exist"
        return false
      end
      unless Reward.find_by(title: online_code_reward).online?
        @errors << "Reward: #{online_code_reward} have post delivery method. You can't create online code for it"
        return false
      end
    end
    true
  end

  def import_online_codes_from_file
    @csv.each do |row|
      online_code = OnlineCode.new(reward_id: Reward.find_by(title: row['Reward name']).id)
      online_code.code = SecureRandom.hex(12)
      online_code.reward.number_of_available_items += 1
      online_code.save!
    end
  end
end
