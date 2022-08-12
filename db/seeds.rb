5.times do |i|
    Employee.where(email: "email#{i}@test.com").first_or_create!(name: "Employee #{i}", description: "An employee.", password: "Password")
  end

Admin.where(email: "admin@test.com").first_or_create!(password: "Password1")

CompanyValue.where(title: "Honesty").first_or_create!
CompanyValue.where(title: "Ownership").first_or_create!
CompanyValue.where(title: "Accountability").first_or_create!
CompanyValue.where(title: "Passion").first_or_create!

10.times do |j|
  Kudo.create(title: "Kudo #{j+1}", content: "A kudo.", giver_id: Employee.all.sample.id, receiver_id: Employee.all.sample.id, company_value: CompanyValue.all.sample)
end

5.times do |m|
  Category.create(title: "Category #{m+1}")
end

5.times do |k|
  Reward.create(category_id: Category.all.sample.id, title: "Reward #{k+1}", description: "A reward.", price: k+1)
end

4.times do |l|
  Order.create(reward_id: Reward.all.sample.id, employee_id: Employee.all.sample.id, purchase_price: "#{l+1}")
end
