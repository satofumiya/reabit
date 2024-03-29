class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  def new
    @book = current_user.books.find(params[:book_id])
    @post = current_user.posts.build(book: @book)
  end

  def create
    @book = current_user.books.find(params[:post][:book_id])
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = "投稿が作成されました"
      redirect_to page_path(current_user)
    else
      flash[:alert] = "投稿の作成に失敗しました"
      render :new, locals: { book_id: params[:post][:book_id] }
    end
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:content, :book_id)
  end
end
