class User < ActiveRecord::Base
    has_many :jokes
end