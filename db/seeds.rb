# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Clearing database"

LineItem.destroy_all
Cart.destroy_all
Order.destroy_all
Variant.destroy_all
Product.destroy_all
SubCategory.destroy_all
Category.destroy_all
User.destroy_all

puts "creating users"

User.create! email: "buyer@mail.com", password: 123456, permission_level: 0
User.create! email: "admin@mail.com", password: 123456, permission_level: 1
User.create! email: "super_admin@mail.com", password: 123456, permission_level: 2


puts "creating categories"

habitacion = Category.create! name: "Habitación", photo: "url"
cocina = Category.create! name: "Cocina", photo: "url"
living = Category.create! name: "Living", photo: "url"



puts "creating subcategories"

cubrecamas = SubCategory.create! name: "Cubrecamas", category: habitacion
sabanas = SubCategory.create! name: "Sabanas", category: habitacion
mantas = SubCategory.create! name: "Mantas", category: habitacion
SubCategory.create! name: "Almohadas", category: habitacion
SubCategory.create! name: "Almohadones", category: habitacion
mantitas = SubCategory.create! name: "Mantas", category: living
almohadones = SubCategory.create! name: "Almohadones", category: living


puts "finish"
