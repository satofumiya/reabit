class AddBookIdToPosts < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :book, null: false, foreign_key: true
  end
end
