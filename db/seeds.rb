# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do |i|
    Employee.where(email: "email#{i}@test.com").first_or_create!(name: "Employee #{i}", description: "An employee.", password: "Password")
  end
  
3.times do |j|
    Kudo.create(title: "Kudo #{j+1}", content: "A kudo.", giver_id: "#{j+1}", receiver_id: "#{j+1}")
  end
  