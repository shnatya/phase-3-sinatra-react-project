require "pry"
class JokesController < ApplicationController

    get "/jokes" do
        jokes = Joke.all 
        jokes.to_json(only: [:question, :answer], include: [:user, :categories])
    end

    get "/jokes/:category_id" do
        array_jokes = []
        category = Category.find(params[:category_id])
        category.jokes.each do |joke|
            array_jokes << {question: joke.question, answer: joke.answer, username: joke.user.username}
        end
        array_jokes.to_json(include: :user)
    end
    
    post "/jokes" do
        user = User.find_or_create_by(username: params[:user][:username])
        joke = user.jokes.create(params[:joke])
        joke.to_json
        
        array_joke_category_instances = []
        array_categories = params[:category][:category_name].split(/, /)
        array_categories.each do |category|
            category_instance = Category.find_or_create_by(category_name: category) #need to send
            #category name or new category name
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
            j_c.destroy
            #j_c.to_json Didn't work
            array_deleted_joke_categories << j_c
        end
        array_deleted_joke_categories.to_json
    end
end

