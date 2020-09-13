# frozen_string_literal: true

require 'pry'

class PostsController < ApplicationController
  include CableReady::Broadcaster

  def index
    @posts = Post.order(created_at: :desc).limit(10)

    @post = Post.new
    @comment = Comment.new
  end

  def create
    post = Post.create(post_params)

    cable_ready['feed'].insert_adjacent_html(
      selector: '#feed',
      position: 'afterbegin',
      html: render_to_string(partial: 'posts/post', locals: { post: post })
    )
    cable_ready.broadcast

    redirect_to posts_path
  end

  def add_comment
    comment = Comment.create(body: params[:comment][:body], post_id: params[:post_id])
    cable_ready['feed'].insert_adjacent_html(
      selector: '#feed',
      position: 'afterbegin',
      html: render_to_string(partial: 'posts/comments', locals: { comment: comment })
    )
    cable_ready.broadcast

    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end

  def comment_params
    params.permit(:body, :post_id)
  end
end
