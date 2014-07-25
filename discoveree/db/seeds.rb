# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
shuff = User.create(email: "shuff@shuff.com", password: "shuffshuff", password_confirmation: "shuffshuff")
category = Category.create(name: "Haskell")

10.times do
  shuff.categories << Category.create(name: "blah blah I'm a category")
end

shuff.categories.each do |category|
  category.contents << Content.create(url: "http://google.com")
end
