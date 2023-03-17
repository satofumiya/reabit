class Api::BooksController < ApplicationController
  def index
    @books = Book.order('created_at DESC')
  end
end
