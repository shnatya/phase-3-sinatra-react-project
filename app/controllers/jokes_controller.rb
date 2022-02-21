require "pry"
class JokesController < ApplicationController

    get "/jokes" do
        jokes = Joke.all
        jokes.to_json(include: :user)
    end

    get "/jokes/:category_name" do
        capitalized_category(params[:category_name]) #private method?

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
        
        array_joke_category_instances = []
        array_categories = params[:category][:category_name].split(/, /)
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
    end

    private

    def capitalized_category(category)
        @capitalized_category = category.capitalize()
    end
end

