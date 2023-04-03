class PagesController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
    @books =  @user.books.where(finished: true)
    @posts = @user.posts
  end
end
