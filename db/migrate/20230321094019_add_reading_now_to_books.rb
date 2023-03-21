class AddReadingNowToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :reading_now, :boolean, default: false
  end
end
