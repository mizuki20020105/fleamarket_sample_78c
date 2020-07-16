Rails.application.routes.draw do
  # rootはトップページに指定
  root 'items#index'

  # userに関する記載箇所
  devise_for :users
  resources :users, only: [:index, :edit, :update, :show, :destroy], shallow: true do
    resources :send_informations, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :profiles, only: [:new, :create, :index, :edit, :show]
  end

  # profileに関する記載箇所

  # send_informationに関する記載箇所

  # itemに関する記載箇所
  resources :items do
    member do
      get 'buy', 'p_exhibiting', 'p_transaction', 'p_soldout'
      post 'pay'
    end
  end

  # creditに関する記述
  resources :credits, only: [:index, :new , :create, :show, :destroy]

  # categoryに関する記述
  resources :categories ,only: :index

end
