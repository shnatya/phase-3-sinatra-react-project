class Joke < ActiveRecord::Base
    belongs_to :user
    has_many :joke_categories
    has_many :categories, through: :joke_categories
    #validates_presence_of :question, :answer
end