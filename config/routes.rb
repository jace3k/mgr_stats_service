Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/product_stats', to: 'stats#product_stats'
  get '/order_stats', to: 'stats#order_stats'
end
