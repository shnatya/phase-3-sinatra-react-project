class CreateJokes < ActiveRecord::Migration[6.1]
  def change
    create_table :jokes do |t|
      t.string :question
      t.string :answer
      t.integer :user_id
    end
  end
end
