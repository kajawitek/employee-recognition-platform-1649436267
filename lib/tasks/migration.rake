namespace :migration do
  desc 'Adds delivery method to existing rewards'
  task add_delivery_method: :environment do
    Reward.all.each { |reward| reward.update(delivery_method: 'online') }
  end
end
