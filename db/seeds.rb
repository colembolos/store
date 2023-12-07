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
  user = User.create!(email: 'user@example.com', password: 'password', role: 0)

  puts 'Users created'

  gr = Product.create(name: 'Green Tea', code: 'GR1', price: 311)
  sr = Product.create(name: 'Strawberries', code: 'SR1', price: 500)
  cf = Product.create(name: 'Coffee', code: 'CF1', price: 1123)

  puts 'Products created'

  user.create_basket

  puts 'Basket Created'

  Promotion.create(product_id: gr.id, promotion_type: :get_one_free, threshold: 2)
  Promotion.create(product_id: sr.id, promotion_type: :bulk_discount, threshold: 3, rules: { discounted_price: 450 })
  Promotion.create(product_id: cf.id, promotion_type: :bulk_percentage, threshold: 2, rules: { discount_percentage: 3333 })

  puts 'Promotions created'
end