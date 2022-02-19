puts "🌱 Seeding users..."

# Seed your database here
User.create(username: "Mom")
User.create(username: "Dad")
User.create(username: "Emily")
User.create(username: "Zoey")

puts "✅ Done seeding users!"

puts "🌱 Seeding jokes ..."

Joke.create(question: "Who always comes to a picnic but is never invited?", answer: "ants", username_id: 1)
Joke.create(question: "What do you call an alligator with a vest?", answer: "an_investigator", username_id: 1)
Joke.create(question: "What kind of button won’t unbutton?", answer: "a_belly_button", username_id: 2)
Joke.create(question: "What starts and ends with an E but contains only one letter?", answer: "an_envelope", username_id: 2)
Joke.create(question: "What do you call a dinosaur that is sleeping", answer: "a_dino_snore", username_id: 3)
Joke.create(question: "What is a vampire’s favorite fruit?", answer: "a_blood_orange", username_id: 3)
Joke.create(question: "What is a witch’s favorite subject in school?", answer: "spelling", username_id: 4)
Joke.create(question: "What sound do hedgehogs make when they hug?", answer: "ouch", username_id: 4)

puts "🌱 Done seeding jokes!"
  
puts "🌱 Seeding categories ..."

Category.create(category_name: "Animals")
Category.create(category_name: "Things")
Category.create(category_name: "Food")
Category.create(category_name: "Fantasy")
Category.create(category_name: "School")
 
puts "🌱 Done seeding categories!"

puts "🌱 Seeding joke_categories ..."

JokeCategory.create(joke_id: 1, category_id: 1)
JokeCategory.create(joke_id: 2, category_id: 1)
JokeCategory.create(joke_id: 3, category_id: 2)
JokeCategory.create(joke_id: 4, category_id: 2)
JokeCategory.create(joke_id: 5, category_id: 1)
JokeCategory.create(joke_id: 6, category_id: 3)
JokeCategory.create(joke_id: 6, category_id: 4)
JokeCategory.create(joke_id: 7, category_id: 4)
JokeCategory.create(joke_id: 7, category_id: 5)
JokeCategory.create(joke_id: 8, category_id: 1)
