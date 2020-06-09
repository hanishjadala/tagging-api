# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin_user = {first_name: 'Admin', last_name: 'User', email: 'admin@tagging.com', password: 'password'}

user = User.new(admin_user)
if user.save
  p "User #{user.first_name} created"
else
  p "User already created"
end