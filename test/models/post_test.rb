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
end
