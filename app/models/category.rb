class Category < ActiveRecord::Base
    has_many :joke_categories
    has_many :jokes, through: :joke_categories
end