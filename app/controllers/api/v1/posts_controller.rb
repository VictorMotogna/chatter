# frozen_string_literal: true

class Api::V1::PostsController < ApplicationController
  include CableReady::Broadcaster

  def index
    @posts = Post.order(created_at: :desc).limit(10)
    render json: @posts
  end

  def create
    post = Post.create(post_params)

    ActionCable.server.broadcast('feed', post: post)

    render json: post
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end
