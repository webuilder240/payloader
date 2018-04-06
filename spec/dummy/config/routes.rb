require 'sidekiq/web'

Rails.application.routes.draw do
  mount Payloader::Engine, at: "/payloader"
  mount Sidekiq::Web, at: "/sidekiq"
  root "home#index"
end
