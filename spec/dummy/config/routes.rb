Rails.application.routes.draw do
  mount Payloader::Engine => "/payloader"
end
