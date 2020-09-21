# frozen_string_literal: true

Rails.application.routes.draw do
  resources :posts, only: %i[index create]
  root 'posts#index'

  namespace :api do
    namespace :v1 do
      resources :posts, only: %i[index create] do
        post :like, on: :member
        post :repost, on: :member
      end
    end
  end
end
