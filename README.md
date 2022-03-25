# Description of the Jokes database API

This project includes two parts - frontend application written in React and backend written using Sinatra and Active Record. In this README.md file, you find the description of the backend part. 

React frontend repository is located [**here**][React link].
[React link]: https://github.com/shnatya/my-app-frontend


## Installation
In the repository of this app, copy information about this repository in **Code** section.
In your terminal, type *git clone* and paste what you have copied from GitHub.

To start the server, type in your terminal: 
  $ bundle exec rake server

This will run your server on port
[http://localhost:9293/jokes](http://localhost:9293/jokes).

To start working with database in your terminal:
  $ bundle exec rake console


## Jokes database

Jokes database has four tables: users, jokes, categories, and joke_categories. Between users and jokes tables, there is one-to-many relationship: a joke has only one user, but a user has many jokes. Thanks to this relationship, you can find out the the user’s name who wrote the joke, and also filter out all jokes for a certain user. 
        
Between jokes and categories tables, there is many-to-many relationship: a joke has many categories, and one category has many jokes. This relationship is established in a join table joke_categories with foreign keys - joke_id and category_id. Thanks to this relationship, you can filter jokes by one category.


## Routing using Sinatra

This API has three routes:

- get "/jokes",
- post "/jokes",
- delete "/jokes/:id". 

Working with this routes,  you request jokes from the database, add new jokes to it, and delete jokes from the database, respectively.


# Jokes References

In this project, jokes were taken from the next websites:
- https://www.skiptomylou.org/kids-jokes/
- https://kidsit.com/kids-jokes

# License
[MIT](https://choosealicense.com/licenses/mit/)