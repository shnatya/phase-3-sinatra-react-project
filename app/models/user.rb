class User < ActiveRecord::Base
    has_many :jokes
    validates :username, presence: true
end