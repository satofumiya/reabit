class RelationshipsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    if current_user.following?(user)
      flash[:error] = "もうこのユーザーはフォローされています."
    elsif user == current_user
      flash[:error] = "自分をフォローすることはできません."
    else
      current_user.follow(user)
      flash[:success] = "#{user.name}をフォローしました！."
    end
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end
end
