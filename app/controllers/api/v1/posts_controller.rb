# frozen_string_literal: true

class Api::V1::PostsController < ApplicationController
  include CableReady::Broadcaster

  before_action :set_post, only: [:like, :repost]

  def index
    @posts = Post.order(created_at: :desc).limit(10)
    render json: @posts
  end

  def create
    @post = Post.create(post_params)
    broadcast_post

    render json: @post
  end

  def like
    @post.increment! :likes_count
    broadcast_post

    render json: @post
  end

  def repost
    @post.increment! :reposts_count
    broadcast_post

    render json: @post
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def broadcast_post
    ActionCable.server.broadcast('feed', post: @post)
  end
end
