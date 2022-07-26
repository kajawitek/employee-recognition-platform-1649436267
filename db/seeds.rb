5.times do |i|
    Employee.where(email: "email#{i}@test.com").first_or_create!(name: "Employee #{i}", description: "An employee.", password: "Password")
  end

Admin.where(email: "admin@test.com").first_or_create!(password: "Password1")

CompanyValue.where(title: "Honesty").first_or_create!
CompanyValue.where(title: "Ownership").first_or_create!
CompanyValue.where(title: "Accountability").first_or_create!
CompanyValue.where(title: "Passion").first_or_create!

5.times do |j|
  Kudo.create(title: "Kudo #{j+1}", content: "A kudo.", giver_id: "#{j+1}", receiver_id: "#{j+1}", company_value: CompanyValue.all.sample)
end

5.times do |k|
  Reward.create(title: "Reward #{k+1}", description: "A reward.", price: k+1)
end

4.times do |l|
  Order.create(reward_id: "#{l+1}", employee_id: "#{l+1}", purchase_price: "#{l+1}")
end
