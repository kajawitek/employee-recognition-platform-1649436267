puts '# Creating Employees'
5.times do |e|
  employee = Employee.where(email: "email#{e+1}@test.com").first_or_create!(first_name: "First name #{e+1}", last_name: "Last name #{e+1}", password: "Password", number_of_available_points: 3)
  puts employee.email
end

puts '# Creating Admin'
admin = Admin.where(email: "admin@test.com").first_or_create!(password: "Password1")
puts admin.email

puts '# Creating Company Values'
["Honesty", "Ownership", "Accountability", "Passion"].each do |comp_val|
  company_value = CompanyValue.where(title: comp_val).first_or_create!
  puts company_value.title
end

puts '# Creating Kudos'
10.times do |k|
  kudo = Kudo.create(title: "Kudo #{k+1}", content: "A kudo.", giver_id: Employee.all.sample.id, receiver_id: Employee.all.sample.id, company_value: CompanyValue.all.sample)
  puts kudo.title
end

puts '# Creating Categories'
5.times do |c|
  category = Category.where(title: "Category #{c+1}").first_or_create!
  puts category.title
end

puts '# Creating Rewards'
reward_1 = Reward.create(category_id: Category.all.sample.id, title: "Reward 1", description: "A reward.", price: 1, delivery_method: "online")
puts reward_1.title

reward_2 = Reward.create(category_id: Category.all.sample.id, title: "Reward 2", description: "A reward.", price: 2, delivery_method: "post", number_of_available_items: 3)
puts reward_2.title

reward_3 = Reward.create(category_id: Category.all.sample.id, title: "Reward 3", description: "A reward.", price: 3, delivery_method: "online")
puts reward_3.title

reward_4 = Reward.create(category_id: Category.all.sample.id, title: "Reward 4", description: "A reward.", price: 4, delivery_method: "online")
puts reward_4.title

reward_5 = Reward.create(category_id: Category.all.sample.id, title: "Reward 5", description: "A reward.", price: 4, delivery_method: "post", number_of_available_items: 5)
puts reward_5.title

puts '# Creating Orders'
4.times do |o|
  order = Order.create(reward_id: Reward.all.sample.id, employee_id: Employee.all.sample.id, purchase_price: "#{o+1}")
  puts order.id
end

puts '# Create Online Codes'

10.times do |oc|
  online_code = OnlineCode.create(code: SecureRandom.hex(12), reward: Reward.all.online.sample)
  online_code.reward.increment!(:number_of_available_items, 1)
  puts online_code.code
end
