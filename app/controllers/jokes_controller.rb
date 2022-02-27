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
        user = User.find_or_create_by(username: params[:user][:username])
        joke = user.jokes.create(params[:joke])
        joke.to_json
        
        array_joke_category_instances = []
        array_categories = params[:category][:category_name].strip.split(/, /)
        array_categories.each do |category|
            category_instance = Category.find_or_create_by(category_name: category) 
            joke_category = JokeCategory.create(
                joke_id: joke.id,
                category_id: category_instance.id)

            array_joke_category_instances << joke_category
        end
        array_joke_category_instances.to_json
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
            if category.jokes.exists?
            else
                category.destroy
                category.to_json # do we need it here? Should i use this info to update my list of
                #categories on the screen?
            end
        end
        array_deleted_joke_categories.to_json
    end
end

