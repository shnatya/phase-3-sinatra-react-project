class Joke < ActiveRecord::Base
    belongs_to :user
    has_many :joke_categories
    has_many :categories, through: :joke_categories
    validates :question, presence: true
    validates :answer, presence: true
end