puts '# Creating Employees'
5.times do |i|
  employee = Employee.where(email: "email#{i+1}@test.com").first_or_create!(first_name: "First name #{i+1}", last_name: "Last name #{i+1}", password: "Password", number_of_available_points: 3)
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
10.times do |j|
  kudo = Kudo.create(title: "Kudo #{j+1}", content: "A kudo.", giver_id: Employee.all.sample.id, receiver_id: Employee.all.sample.id, company_value: CompanyValue.all.sample)
  puts kudo.title
end

puts '# Creating Categories'
5.times do |m|
  category = Category.where(title: "Category #{m+1}").first_or_create!
  puts category.title
end

puts '# Creating Rewards'
5.times do |k|
  reward = Reward.create(category_id: Category.all.sample.id, title: "Reward #{k+1}", description: "A reward.", price: k+1, delivery_method: Reward.delivery_methods.values.sample)
  puts reward.title
end

puts '# Creating Orders'
4.times do |l|
  order = Order.create(reward_id: Reward.all.sample.id, employee_id: Employee.all.sample.id, purchase_price: "#{l+1}")
  puts order.id
end
