# frozen_string_literal: true

class Rails::PostsController < ApplicationController
  before_action :set_post, only: [:like, :repost]

  def index
    @posts = Post.order(created_at: :desc).limit(10)
    @post = Post.new
  end

  def create
    @post = Post.create!(post_params)

    redirect_to rails_posts_path
  end

  def like
    @post.increment! :likes_count

    redirect_to rails_posts_path
  end

  def repost
    @post.increment! :reposts_count

    redirect_to rails_posts_path
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
