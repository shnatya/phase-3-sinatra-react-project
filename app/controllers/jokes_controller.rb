require "pry"
class JokesController < ApplicationController

    get "/jokes" do
        jokes = Joke.all
        jokes.to_json(include: :user)
    end

    get "/jokes/:category_name" do
        capitalized_category(params[:category_name])

        array_jokes = []
        category = Category.find_by(category_name: @capitalized_category)
        array_joke_categories = JokeCategory.where(category_id: category.id)
        array_joke_categories.each do |j_c|
            array_jokes << {question: j_c.joke.question, answer: j_c.joke.answer, username: j_c.joke.user.username}
        end
        array_jokes.to_json
    end
    
    post "/jokes" do
        user = User.find_or_create_by(username: params[:user][:username])
        joke = user.jokes.create(params[:joke])
        joke.to_json

        #array_category = []
        category = Category.find_or_create_by(category_name: params[:category][:category_name])
        joke_category = JokeCategory.create(
            joke_id: joke.id,
            category_id: category.id
        )
        joke_category.to_json
    end
    
    delete "/jokes/:id" do
        joke = Joke.find(params[:id])
        joke.destroy
        joke.to_json
    end

    private

    def capitalized_category(category)
        @capitalized_category = category.capitalize()
    end
end

