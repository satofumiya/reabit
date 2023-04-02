class AddReadingAtToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :reading_at, :datetime
  end
end
