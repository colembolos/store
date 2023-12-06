# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# db/seeds.rb
if Rails.env.development?
  User.create!(email: 'admin@example.com', password: 'password', role: 1)
  User.create!(email: 'user@example.com', password: 'password', role: 0)

  puts 'Users created'

  Product.create(name: 'Green Tea', code: 'GR1', price: 311)
  Product.create(name: 'Strawberries', code: 'SR1', price: 500)
  Product.create(name: 'Coffee', code: 'CF1', price: 1123)

  puts 'Products created'
end