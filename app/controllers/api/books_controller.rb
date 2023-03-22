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

  def update
    @book = Book.find_by(id: params[:id])
    @book.update(book_params)
  end

  private
    def book_params
      params.require(:book).permit(:title, :page_count, :reading_now)
    end
end
