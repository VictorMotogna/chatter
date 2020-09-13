# frozen_string_literal: true

Rails.application.routes.draw do
  resources :posts, only: %i[index create] do
    post :add_comment, on: :collection
  end
  root 'posts#index'
end
