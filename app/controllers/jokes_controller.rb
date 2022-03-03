require "pry"
class JokesController < ApplicationController

    get "/jokes" do
        jokes = Joke.all 
        jokes.to_json( include: [:user, :categories])
    end

    get "/jokes/:category_id" do # i dont' need this route?
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
        
        array_categories = params[:category][:category_name].strip.split(/, /)
        array_categories.each do |category|
            category_instance = Category.find_or_create_by(category_name: category) 
            joke_category = JokeCategory.create(
                joke_id: joke.id,
                category_id: category_instance.id)
        end
        joke.to_json(include: [:user, :categories])
    end
    
    delete "/jokes/:id" do
        array_of_deleted_objects = [{id: "array of deleted objectss"}]
        joke = Joke.find(params[:id])
        joke.destroy
        array_of_deleted_objects << joke

        
        joke.joke_categories.each do |j_c|
            category = j_c.category
            j_c.destroy
            array_of_deleted_objects << j_c

            #Delete a category if there is no more questions from this category
            if !category.jokes.exists?
                category.destroy
                array_of_deleted_objects << category 
            end
        end
        array_of_deleted_objects.to_json
    end
end

