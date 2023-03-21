class Api::BooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      render :show, status: :created
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
  end

  private
    def book_params
      params.permit(:title, :page_count)
    end
end
