class AddFinishedToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :finished, :boolean, default: false
  end
end
