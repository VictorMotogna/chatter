require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test "valid post" do
    post = Post.create!(body: 'valid post')
    assert post.valid?
  end

  test "invalid post - nil body" do
    post = Post.create(body: nil)
    assert post.invalid?
  end

  test "valid post with username" do
    post = Post.create(body: 'new post', username: 'user')
    assert post.valid?
  end

  test "valid post with like count" do
    post = Post.create(body: 'new post', username: 'user', likes_count: 2)
    assert post.valid?
  end
end
