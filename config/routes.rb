# frozen_string_literal: true

Rails.application.routes.draw do
  resources :posts, only: %i[index create]
  root 'posts#index'

  namespace :api do
    namespace :v1 do
      resources :posts, only: %i[index create]
    end
  end
end
