class CreateJokeCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :joke_categories do |t|
      t.integer :joke_id
      t.integer :category_id
    end
  end
end
