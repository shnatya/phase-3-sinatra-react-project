class CategoriesController < ApplicationController

    get '/categories' do
        categories = Category.all
        categories.to_jsons
    end 
end