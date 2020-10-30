# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Clearing database"

SubCategory.destroy_all
Category.destroy_all
User.destroy_all

puts "creating users"

User.create! email: "admin@mail.com", password: 123456, permission_level: 1

puts "creating categories"

sabanas = Category.create! name: "sabanas", photo: "url"

puts "creating subcategories"

SubCategory.create! name: "algo", category: sabanas

puts "finish"
