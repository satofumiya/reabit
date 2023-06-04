class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @like = current_user.likes.new(post: @post)
    if @like.invalid?
      flash[:alert] = @like.errors.full_messages.to_sentence
    else
      @like.save
    end
    redirect_to root_path
  end
end
