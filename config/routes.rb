Rails.application.routes.draw do

  resources :categories, only: [:show]

  namespace :admin do
    get 'categories/index'
  end

  namespace :admin do
    get 'categories/new'
  end

  root 'welcome#index'

  devise_for :users

  namespace :admin do
    resources :products do
      resources :product_images, only: [:index, :create, :destroy, :update]
    end
    resources :categories
    resources :orders do
      member do
        post :cancel
        post :ship
        post :shipped
        post :return
      end
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :products do
    member do
      post :add_to_cart
    end
  end

  resources :carts do
    collection do
      delete :clean
        post :checkout
    end
  end

  resources :cart_items

  resources :orders do
    member do
      post :pay_with_alipay
      post :pay_with_wechat
      post :apply_to_cancel
    end
  end

  namespace :account do
    resources :orders
    resources :setting
    resources :favlist
  end

end
