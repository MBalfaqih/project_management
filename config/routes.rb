Rails.application.routes.draw do
  

  #get 'api/v1/sessions/index'

  namespace 'api' do
    namespace 'v1' do
      resources :sessions , only: [:create , :destroy]
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
