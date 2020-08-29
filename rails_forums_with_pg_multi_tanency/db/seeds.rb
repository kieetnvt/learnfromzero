# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

u = User.create(email: "foo@example.com", password: "secret") unless User.find_by_email("foo@example.com")

t = u.topics.find_or_create_by name: "Limburger Pranks"
t.posts.find_or_create_by content: "Try putting it under someone's nose when they sleep. Haha."
t.posts.find_or_create_by content: "No Whey!"
t.posts.find_or_create_by content: "That's a Gouda one."

t = u.topics.find_or_create_by name: "Four-Cheese Pizza Recipe"
t.posts.find_or_create_by content: "It's delicious!"

t = u.topics.find_or_create_by name: "The best Cheesecake"
t.posts.find_or_create_by content: "Where's the best cheesecake you've tried?"
t.posts.find_or_create_by content: "I hear Ryan has a good recipe."

t = u.topics.find_or_create_by name: "What's your favorite cheese?"
t.posts.find_or_create_by content: "What's your favorite?"
