class PagesController < ApplicationController
  def index
    @posts = Post.all.page(params[:page]).per(5)
    post_ids = Like.group(:post_id).order('count(post_id) desc').pluck(:post_id)
    @post_like_ranks = Post.where(id: post_ids).page(params[:page]).per(5)
  end

  def show
    @user = User.find(params[:id])
    @books =  @user.books.where(finished: true)
    @current_month_reads = @books.where(reading_at: Time.current.all_month)
    @current_year_reads = @books.where(reading_at: Time.current.all_year)
    @posts = @user.posts.page(params[:page]).per(10)
  end
end
