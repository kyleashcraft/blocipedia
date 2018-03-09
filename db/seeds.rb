# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'random_data'

10.times do
  User.create!(
    email: Faker::Internet.unique.email,
    password: 'password'
  )
end

5.times do
  User.create!(
    email: Faker::Internet.unique.email,
    password: 'password',
    role: 1
  )
end

User.create!(
  email: "admin@blocipedia.com",
  password: 'password',
  role: 2
)

standard_users = User.where(role: 0).all
premium_users = User.where(role: 1).all
admin = User.where(role: 2).all

users = User.all

puts "#{standard_users.count} standard users created."
puts "#{premium_users.count} premium users created."
puts "#{admin.count} admin created."

20.times do
  Wiki.create!(
    title: Faker::Hipster.unique.sentence,
    body: Faker::Hipster.unique.paragraph,
    user: users.sample,
    private: false
  )
end

5.times do
  Wiki.create(
    title: Faker::Hipster.unique.sentence,
    body: Faker::Hipster.unique.paragraph,
    user: users.sample,
    private: true
  )
end

public_wikis = Wiki.where(private: false).all
private_wikis = Wiki.where(private: true).all
wikis = Wiki.all

puts "#{public_wikis.count} public wikis created."
puts "#{private_wikis.count} private wikis created."


collab = Collaborator.create(
  user: premium_users.sample,
  wiki: private_wikis.sample
)

puts "#{collab.user.email} added as a collaborator for #{collab.wiki.title} which is owned by #{collab.wiki.user.email}"
