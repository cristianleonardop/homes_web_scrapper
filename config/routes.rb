Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :homes do
    match '/spider', to: 'homes#spider', via: :post, on: :collection
  end

  root to: 'homes#index'
end
