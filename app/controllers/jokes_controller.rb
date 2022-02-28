require "pry"
class JokesController < ApplicationController

    get "/jokes" do
        jokes = Joke.all 
        jokes.to_json( include: [:user, :categories])
    end

    get "/jokes/:category_id" do
        array_jokes = []
        category = Category.find(params[:category_id])
        category.jokes.each do |joke|
            array_jokes << {id: joke.id, question: joke.question, answer: joke.answer, user: joke.user}
        end
        array_jokes.to_json
    end
    
    post "/jokes" do
        array_of_objects = []
        user = User.find_or_create_by(username: params[:user][:username])
        joke = user.jokes.create(params[:joke])
        array_of_objects << joke
        
        array_categories = params[:category][:category_name].strip.split(/, /)
        array_categories.each do |category|
            category_instance = Category.find_or_create_by(category_name: category) 
            joke_category = JokeCategory.create(
                joke_id: joke.id,
                category_id: category_instance.id)

        array_of_objects << joke_category
        end
    array_of_objects.to_json
    end
    
    delete "/jokes/:id" do
        
        joke = Joke.find(params[:id])
        joke.destroy
        joke.to_json

        array_deleted_joke_categories = []
        joke.joke_categories.each do |j_c|
            category = j_c.category
            j_c.destroy
            array_deleted_joke_categories << j_c

            #Delete a category if there is no more questions from this category
            if !category.jokes.exists?
                category.destroy
                category.to_json # do we need to send a json response here? 
            end
        end
        array_deleted_joke_categories.to_json
    end
end

