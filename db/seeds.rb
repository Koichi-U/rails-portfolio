# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create!(username:  "Admin",
             email: "admin@example.jp",
             password:  "11111111",
             password_confirmation: "11111111",
             admin: true)

5.times do |n|
  User.create!(username:  "User#{n + 1}",
               email: "user#{n + 1}@example.jp",
               password:  "11111111",
               password_confirmation: "11111111",
               admin: false)
end