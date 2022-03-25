class User < ActiveRecord::Base
    has_many :jokes
    #validates_presence_of :username
end