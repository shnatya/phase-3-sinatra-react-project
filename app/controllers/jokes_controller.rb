require "pry"
class JokesController < ApplicationController

    get "/jokes" do
        jokes = Joke.all
        jokes.to_json(include: [:user, :categories])
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
        errors = []
        user = User.find_or_create_by(username: params[:user][:username])

        if !user.id
            errors = errors.concat(user.errors.full_messages)
            
            joke = user.jokes.build(params[:joke])
            unless joke.valid?
                errors = errors.concat(joke.errors.full_messages)
                
            end
        else 
            joke = user.jokes.build(params[:joke])
            unless joke.save
                errors = errors.concat(joke.errors.full_messages)
            end
        end

        if user.id && joke.save
            array_categories = params[:category][:category_name].strip.split(/, /)
            array_categories.each do |category|
                category = category.capitalize
                category_instance = Category.find_or_create_by(category_name: category) 
                joke_category = JokeCategory.create(
                    joke_id: joke.id,
                    category_id: category_instance.id)
            end
            joke.to_json(include: [:user, :categories])
        else 
            { errors: errors}.to_json
        end
    end
    

    
    delete "/jokes/:id" do
        array_of_deleted_objects = []
        joke = Joke.find(params[:id])
        joke.destroy
        array_of_deleted_objects << joke

        
        joke.joke_categories.each do |j_c|
            category = j_c.category
            j_c.destroy

            #Delete a category if there is no more questions from this category
            if !category.jokes.exists?
                category.destroy
                array_of_deleted_objects << category.category_name 
            end
        end
        array_of_deleted_objects.to_json
    end

end

