class PagesController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @user = User.find(params[:id])
    @books =  @user.books.where(finished: true)
    @current_month_reads = @books.where(reading_at: Time.current.all_month)
    @current_year_reads = @books.where(reading_at: Time.current.all_year)
    @posts = @user.posts
  end
end
