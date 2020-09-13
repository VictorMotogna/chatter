# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :post

  validates :body, length: { minimum: 1, maximum: 1000 }
end
