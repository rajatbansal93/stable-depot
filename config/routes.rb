Rails.application.routes.draw do

  # constraints lambda { |request|
  #   p request.env['HTTP_USER_AGENT'].include? "Chrome"

  # }
  class Chrome
    def matches?(request)
      request.env['HTTP_USER_AGENT'].include? "Chrome"
    end
  end

  class Firefox
    def matches?(request)
      request.env['HTTP_USER_AGENT'].include? "Firefox"
    end
  end

  constraints Chrome.new do

    resources :categories

    controller :sessions do
      get 'login' => :new
      post 'login' => :create
      delete 'logout'=> :destroy
    end

    get "/categories/:id/books", to: "products#index"

    namespace :admin do
      resources :reports, only: [:index]
      resources :categories

    end

    resources :users do
      collection do
        get 'orders', to: :show_orders
        get :line_items
      end
    end

    get "my-orders", to: "users#show_orders"
    get "my-items", to: "users#line_items"

    resources :orders
    resources :line_items
    resources :carts
    resources :cartes
    resources :images
    get 'store/index'

    resources :products, path: 'books'

    root 'store#index', as: 'store'
  end

  constraints Firefox.new do
    root 'store#index', as: 'firefox_store'
  end

end
