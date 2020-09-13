# frozen_string_literal: true

class Post < ApplicationRecord
  has_many :comments, dependent: :destroy

  validates :body, length: { minimum: 1, maximum: 1000 }
end
