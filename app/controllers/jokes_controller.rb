require "pry"
class JokesController < ApplicationController

    get "/jokes" do
        jokes = Joke.all
        jokes.to_json(include: :user)
    end
    
    post "/jokes" do
        user = User.find_or_create_by(username: params[:user][:username])
        joke = user.jokes.create(params[:joke])
        joke.to_json

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
end

