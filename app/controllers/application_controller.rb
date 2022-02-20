require 'pry'
class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  # Add your routes here
  get "/jokes" do
    jokes = Joke.all.order(question: :ASC)
    jokes.to_json
  end

  post "/jokes" do
    joke = Joke.create(
      question: params[:question],
      answer: params[:answer],
      user_id: params[:user_id]
    )
    joke.to_json
  end

  delete "/jokes/:id" do
    joke = Joke.find(params[:id])
    joke.destroy
    joke.to_json
  end

end
