puts "🌱 Seeding users..."

# Seed your database here
User.create(username: "Mom")
User.create(username: "Dad")
User.create(username: "Emily")
User.create(username: "Zoey")

puts "✅ Done seeding users!"

puts "🌱 Seeding jokes ..."
Joke.create(question: "Who always comes to a picnic but is never invited?", answer: "ants", username_id: 1)

puts "🌱 Done seeding jpokes!"