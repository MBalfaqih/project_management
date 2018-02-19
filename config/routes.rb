require 'resque/server'
require 'resque/scheduler/server'

Rails.application.routes.draw do
  
  mount Resque::Server.new, at: '/resque'

  scope "(:locale)", locale: /en|ar/ do
    namespace 'v1' do
      
      
      resource :sessions , only: [:create , :destroy ]
      resource :companies , only: [:create , :show , :update ]
      
      resource :passwords , only: [:forgot , :recover , :update] do 
        post :forgot
        put :recover
      end
      
      resources :employees do 
        resource :employee_projects , only: [:show , :update ]
      end 
      
      resources :projects do
        resource :project_employees , only: [:show , :update]
        resources :tasks , except: :show
      end
      
      resource :reports , only: :show
    end
  end

end
